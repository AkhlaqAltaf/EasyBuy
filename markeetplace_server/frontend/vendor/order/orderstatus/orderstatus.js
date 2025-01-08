let currentStep = 1;
    const steps = 4;

    function handleStepClick(step) {
      currentStep = step;
      updateProgress();
    }

    function updateProgress() {
      const progressWidth = `${(currentStep / (steps - 1)) * 100}%`;
      document.getElementById('progressBar').style.width = progressWidth;
      
      for (let i = 0; i < steps; i++) {
        const stepCircle = document.getElementById(`step${i + 1}`);
        const label = document.getElementById(`label${i + 1}`);
        if (i < currentStep) {
          stepCircle.classList.add('bg-[#0B5D51]');
          label.classList.add('text-[#0B5D51]');
        } else {
          stepCircle.classList.remove('bg-[#0B5D51]');
          label.classList.remove('text-[#0B5D51]');
          label.classList.add('text-[#93c6bd]');
        }
      }
    }

    function updateStatus() {
      alert('Status updated!');
    }

    updateProgress();