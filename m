Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B2CCCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 20:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4CBE40291;
	Sat, 17 Oct 2026 22:36:28 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1C42640276
 for <dev@dpdk.org>; Sat, 17 Oct 2026 22:36:26 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8a01cac8733so601036b3a.2
 for <dev@dpdk.org>; Sat, 17 Oct 2026 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792269386;
 x=1792874186; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PGDLY1idJg/ZoxwDW/HrdZZ4PFErPj7/JmH6KLXhIAI=;
 b=Q5KFSUV+ZOASDjunfZZG3ReIBg1/t0stGs0OCMYri5HzDSM5pTNe9ksaDA/So3PRKR
 jm4edtQnqCd+0/bLIMKxSG1GyIHUYih7HYCWLX4rAyu4hplrfwxljp45bCKXTV9kHtf1
 XoqelBT/wHIjrn3vPnJNSPJYDuawQkwvqJwKV8ISv37fwVxGMRNksQmt89Whdgiz0F9k
 SjSTlq7ezMpWykUZAL684VyspoC+aE4EcosmqjDB/fPqiIM8nxkRM76cn1L/ib5inqze
 zMbDvnP66Ckd2H3ifHOJ24WfOZ9tzxHH6AOmJhAuF6KT1Z4cJMOme9gk+pK4085VAKkx
 atAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792269386; x=1792874186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PGDLY1idJg/ZoxwDW/HrdZZ4PFErPj7/JmH6KLXhIAI=;
 b=oyuzGx+khUHGo/gKJO3r54Zc/xK7DI3kJfORX6mvBXd2e28dXeHvmwEvc12NnsZ4Lx
 WF967h1zP+UMKgltGT144myeY99TNfXzCgYQs4qD0GgemUK03dOF5jny3Kk4HCO6JJZV
 n6RoekZKbjED05GJf5v7LRiwyQ9w5c06+MtMiyJh3rb078VZles7OncA0BoSBLq6GMub
 dGjzMidp7N4W87r+EoVqBd67vVow/NaUTbCJytiyR7zCMIKbhMoEgzeBcHmO1wdc3uYq
 vWhk/TowGgRJfrZDRvDfAkTK9wNq+BabJoSfJpgtXL0SvWw4534kzMr6ZWRHncEhfxwg
 bOrQ==
X-Gm-Message-State: AFq9FYJ/MPXUsd44TWPzDMJVH02QyEJdDSP3m5Kx0d60q7ORIS47JJUL
 iYC5hpMBw5ND9CEQGSzQ489abffgEz7rQrkZAFGFAAl896eg5uLLvs4HTPx9q91uUHTteqUsyim
 WxtNEXFM=
X-Gm-Gg: AYBFou3Qv/slY8fKEk1KYQpF2OOJKH0NE2wOF3+GkC9ld0Dq5C1PE5EFvaLSvjs3gsN
 G5RGmARSFdxMXP0oGY4nf+usTrAf2odEHoeCIJUg7eCPbr35cfbaC1xZv8Iyc2ykw3eFHtNJMrt
 8F8r18o0VV2NXMDArZmMRyG7Nfa8CRowFOhq2jOJrVWn/LuW4Us8tOTYwnN86l0WqWbPlroawdL
 EdndBQwz+7v1KCeSqjWJ7zL6qa0eCaZw9BZ6T5Bf7+Q57kKZ/cZOPhzfjssOhQyajnKXeeDg76f
 IhEAVT3aL9XJfb0X85HiEjPZ1zYf/io552QT4U0UKdJYJf9EA39y7GrHZjnfVZamXbr6M9qx2aA
 81l0uwvZGKV0SVzSZajB1XPjKcBQn9iUngblFcJScF0GnhvHnqnb/Hau7ORV1AeiGOicaXnI/R5
 sGC1Wj10d/FyhuRv1qsAOHkygm8ihMAsXHCur6R1PATdMUeWWRrwgq52cbopmrTCRq/X0KnNbsx
 W4MZnNte5BF1NCuJEOIp2/bmSjy3Qla+CevDQ==
X-Received: by 2002:a05:6a00:4404:b0:892:a8f1:c53d with SMTP id
 d2e1a72fcca58-8a04bb360d4mr2554427b3a.22.1792269385867; 
 Sat, 17 Oct 2026 13:36:25 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57653ea9sm2451929b3a.32.2026.10.17.13.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 13:36:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/3] fix bogus interrupt FD leak warnings
Date: Sat, 17 Oct 2026 13:35:02 -0700
Message-ID: <20261017203621.3136254-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Running testpmd with an i40e device on 26.11-rc1 prints a set of FD
leak warnings on port close and on exit:

  Closing ports...
  EAL: Some interrupt handle is leaking a FD: 19
  EAL: Some interrupt handle is leaking a device FD: 18
  Port 0 is closed
  ...
  Bye...
  EAL: Some interrupt handle is leaking a FD: 20
  EAL: Some interrupt handle is leaking a device FD: 18
  EAL: Some interrupt handle is leaking a device FD: 18
  EAL: Some interrupt handle is leaking a FD: 7
  EAL: Some interrupt handle is leaking a FD: 7

The warning is new in 26.11 (commit d770ee9caed0, "interrupts: warn on
leaked FDs"). It is doing its job - one of these is a real leak - but
most of what it reports here is not, and the noise will get reported as
a regression.

There are three distinct causes.

The interrupt source created by rte_intr_callback_register() keeps a
copy of the caller's handle. The copy carries the caller's fd and
dev_fd, but does not own them, so freeing the source complains about
fds that the caller still holds and will close itself.

The VFIO device fd is closed by dev_vfio_release_device() on unmap,
but is left behind in the interrupt handle, so freeing the handle later
reports an fd that is already closed. The VFIO request handle holds the
same fd and has the same problem.

The alarm timerfd is a real leak: it is never closed on EAL cleanup.
FreeBSD was already fixed for this; Linux was not.

Patches 1 and 2 address the bogus warnings, patch 3 the actual leak.
With all three applied the same testpmd run shuts down cleanly with no
warnings.

Open questions:

- Patch 1 clears the fds in the source's copy of the handle. Clearing
  them at dup time, or not duplicating the fds into the source at all,
  may be the better fix.
- Patch 2 resets dev_fd at the two unmap sites. Doing it inside
  dev_vfio_release_device(), next to the close, would cover any other
  caller.

Stephen Hemminger (3):
  eal/linux: do not warn when freeing interrupt source copy
  bus/pci: reset VFIO device FD after release
  eal/linux: close alarm timerfd on cleanup

 drivers/bus/pci/linux/pci_vfio.c |  3 +++
 lib/eal/linux/eal_alarm.c        |  1 +
 lib/eal/linux/eal_interrupts.c   | 18 +++++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

--
2.51.0

Stephen Hemminger (3):
  eal/linux: do not warn when freeing interrupt source copy
  bus/pci: reset VFIO device FD after release
  eal/linux: close alarm timerfd on cleanup

 drivers/bus/pci/linux/pci_vfio.c |  3 +++
 lib/eal/linux/eal_alarm.c        |  1 +
 lib/eal/linux/eal_interrupts.c   | 18 +++++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.53.0

