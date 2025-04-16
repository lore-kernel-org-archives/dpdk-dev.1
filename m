Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05585C369C9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 21:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EB52427A2;
	Wed, 16 Apr 2025 23:45:08 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8D20B41157
 for <dev@dpdk.org>; Wed, 16 Apr 2025 23:45:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7D0C3205250C; Wed, 16 Apr 2025 14:45:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D0C3205250C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744839903;
 bh=NDRSyoFDdQLUjHKewpIie6+ITxjqI8NfbEUBwx02o9Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jw+xmAiXIu3U35IsEBXR6figDxDyBmAn6+dK0gksItYEc6KklnrAzPe5JZOLS2bkE
 V8DcHkmyt2r2WQ9vSfhG8k6JR6EUWU1jcVMK6PZaAiT7egWIyp2Sa3lXDN7CVkrEjk
 svu1zOWwbR3jxU/zI5cvsToZvL4g5T9SqqaYoKcc=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v4 0/4] allow pmdinfo to be inserted and parsed using MSVC
Date: Wed, 16 Apr 2025 14:44:54 -0700
Message-Id: <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
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

DPDK uses GCC attribute "used" through macro __rte_used to indicate
that a variable not referenced in the code should be assumed being
used and therefore not be optimized away. This technique is used to embed
information in the binaries, by having crafted information stored in
them.

MSVC offers similar functionality, but it differs significantly: MSVC
requires a pragma to be used to send a command to the linker telling it
explicitly the name of the symbol that should be included (even if not
referenced). As a side-effect, variables called out to be included cannot
be static, otherwise their symbols are not "seen" by the linker. This
restriction requires some DPDK code to be refactored.

Macro RTE_INCLUDE is used in this patch to ensure these special variables
make it to the final binaries.

The elimination of "static" for some of these variables caused name
clashes when __COUNTER__ predefined macro was used. As a workaround,
predefined macro __LINE__ was used instead. However, when __COUNTER__
was used directly from a header file, __LINE__ had to be used from the
.c files, otherwise it would also not result in a unique symbol. This
required a parameter to be added to some macros so that the __LINE__
could be passed from the .c file to the macro defined in the header
(which was originally using __COUNTER__).

With this patchset commands like the one below provide the same JSON
output as would be obtained on Linux.

python usertools\dpdk-pmdinfo.py build\app\dpdk-testpmd.exe

v4:
 - limited the use of __LINE__ to the header files, reducing number of
   changes made in previous versions of this patchset.

v3:
 - ge-pmdinfo-cfile.py: fixed archiver's syntax to extract object from
   library
 - dpdk-pmdinfo.py: removed is_windows() and replaced with
   os.name == "nt"

v2:
 - dpdk-pmdinfo.py: not importing elftools on Windows
 - not requiring "pefile" Python module during build
 - gen-pmdinfo-cfile.py: renamed "ar" to "archiver"

Andre Muezerie (4):
  eal: add macro to embed information in binaries
  buildtools: use macro to embed information in binaries
  usertools: parse strings from PE images
  drivers: use macro to embed information in binaries

 buildtools/gen-pmdinfo-cfile.py              | 24 +++++++--
 buildtools/meson.build                       |  4 +-
 buildtools/pmdinfogen.py                     | 11 ++--
 drivers/bus/auxiliary/bus_auxiliary_driver.h |  2 +-
 drivers/bus/cdx/bus_cdx_driver.h             |  5 +-
 drivers/bus/dpaa/bus_dpaa_driver.h           |  2 +-
 drivers/bus/fslmc/bus_fslmc_driver.h         |  4 +-
 drivers/bus/ifpga/bus_ifpga_driver.h         |  2 +-
 drivers/bus/pci/bus_pci_driver.h             |  2 +-
 drivers/bus/platform/bus_platform_driver.h   |  2 +-
 drivers/bus/uacce/bus_uacce_driver.h         |  2 +-
 drivers/bus/vdev/bus_vdev_driver.h           |  2 +-
 drivers/bus/vmbus/bus_vmbus_driver.h         |  2 +-
 drivers/common/mlx5/mlx5_common.c            |  2 +-
 drivers/common/mlx5/mlx5_common_pci.c        |  2 +-
 drivers/common/nitrox/nitrox_device.c        |  1 +
 drivers/compress/mlx5/mlx5_compress.c        |  2 +-
 drivers/crypto/mlx5/mlx5_crypto.c            |  2 +-
 drivers/event/octeontx/ssovf_evdev.c         |  1 +
 drivers/net/mlx4/mlx4.c                      |  2 +-
 drivers/net/mlx5/mlx5.c                      |  2 +-
 drivers/net/virtio/virtio_pci_ethdev.c       |  2 +-
 drivers/regex/mlx5/mlx5_regex.c              |  2 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c                |  2 +-
 lib/eal/common/eal_common_options.c          |  2 +-
 lib/eal/include/rte_common.h                 |  6 +++
 lib/eal/include/rte_dev.h                    | 14 ++----
 usertools/dpdk-pmdinfo.py                    | 53 ++++++++++++++++----
 28 files changed, 106 insertions(+), 53 deletions(-)

--
2.49.0.vfs.0.0

