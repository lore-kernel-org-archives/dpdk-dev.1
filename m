Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98197C71135
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 01:57:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3F3340B9F;
	Thu, 12 Jun 2025 03:57:55 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mails.dpdk.org (Postfix) with ESMTP id DCB11402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 16:56:23 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A0DB6000A;
 Wed, 11 Jun 2025 14:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAA8C4CEEA;
 Wed, 11 Jun 2025 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749653783;
 bh=xdqge7uTpoTpHLEFra5w8q+pka6hoLjqTwb/aOY4lM4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=a0z/AwwQu/Ft47UTvyQKZmhcnQ1jFSJhZR92JHfGf/T4BhS2w0SAbJWd3TWvLLnMK
 qw0seqh/fgPe3BNOf9SiAVU1MTJb2gbbNX5vr955GkOJKkka9Txy1L+k8sBAfe58K3
 qF/wRxG2p/r6aSf6scs8J92B2ckeqydGmsIk2aikoTpLRE3KCFncit5qw0RS8PhB1Q
 EOkUwuxTCt2Qq1Ddpi5CkBYc3L3m026+6p7KjkNGAKpyun6fA5aYxwzxenYDzzUYd6
 ujmQ1e4pSX2Q+UpfgdT+RxQSJjp9d3UhAtdXYBaOLwxlaGPG4g1olAVRmf17rfLLEN
 UHVGUxMJueEzA==
Message-ID: <f81db934-5109-4e6e-aebb-7b874f98329f@kernel.org>
Date: Wed, 11 Jun 2025 07:56:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
To: nicolas.dichtel@6wind.com, Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 rafael.j.wysocki@intel.com, huang.ying.caritas@gmail.com,
 stern@rowland.harvard.edu, linux-pci@vger.kernel.org,
 Olivier MATZ <olivier.matz@6wind.com>, "dev@dpdk.org" <dev@dpdk.org>
References: <20250505230632.GA1007257@bhelgaas>
 <3d09359f-6e38-4e48-9d4e-6bc203c49e61@6wind.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <3d09359f-6e38-4e48-9d4e-6bc203c49e61@6wind.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Jun 2025 03:57:54 +0200
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

On 6/11/2025 7:14 AM, Nicolas Dichtel wrote:
> Le 06/05/2025 à 01:06, Bjorn Helgaas a écrit :
>> On Wed, Apr 23, 2025 at 11:31:32PM -0500, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> AMD BIOS team has root caused an issue that NVME storage failed to come
>>> back from suspend to a lack of a call to _REG when NVME device was probed.
>>>
>>> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
>>> added support for calling _REG when transitioning D-states, but this only
>>> works if the device actually "transitions" D-states.
>>>
>>> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
>>> devices") added support for runtime PM on PCI devices, but never actually
>>> 'explicitly' sets the device to D0.
>>>
>>> To make sure that devices are in D0 and that platform methods such as
>>> _REG are called, explicitly set all devices into D0 during initialization.
>>>
>>> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Applied to pci/pm for v6.16, thanks!
>>
> 
> I've a regression after this commit.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d4c10f763d7
> 
> I've started a QEMU with "-cpu host" on an AMD (AMD Ryzen 5 3600 6-Core
> Processor) machine + virtio-net interfaces. When I try to start a testpmd (a
> DPDK app), it cannot find the virtio port. The ioctl VFIO_GROUP_GET_DEVICE_FD fails.
> 
> To reproduce the issue:
> qemu-system-x86_64 --enable-kvm -m 5G -cpu host \
> 	-smp sockets=1,cores=2,threads=2 \
> 	-snapshot -vga none -display none -nographic \
> 	-drive if=none,file=/opt/vm/ubuntu-24.04-with-linux-net.qcow2,id=hda \
> 	-device virtio-blk,drive=hda \
> 	-device virtio-net,netdev=eth0,addr=03 -netdev user,id=eth0 \
> 	-device virtio-net,netdev=eth1,addr=04 -netdev socket,id=eth1,mcast=230.0.0.1:1234
> 
> git clone git://dpdk.org/dpdk
> cd dpdk/
> meson build-static --werror --default-library=static --debug
> ninja -C build-static
> echo 3 > /proc/sys/vm/drop_caches
> echo 256 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
> modprobe vfio-pci
> lspci
> python3 ./usertools/dpdk-devbind.py --noiommu-mode -b vfio-pci 0000:00:04.0
> ./build-static/app/dpdk-testpmd -l 1,2 --socket-mem 512,0 -a 0000:00:04.0 -- -i
> 
> Here is the output:
> EAL: Detected CPU lcores: 4
> EAL: Detected NUMA nodes: 1
> EAL: Detected static linkage of DPDK
> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> EAL: Selected IOVA mode 'PA'
> EAL: VFIO support initialized
> EAL: Using IOMMU type 8 (No-IOMMU)
> EAL: Getting a vfio_dev_fd for 0000:00:04.0 failed
> PCI_BUS: Cannot get offset of region 0.
> PCI_BUS: fail to disable req notifier.
> PCI_BUS: fail to disable req notifier.
> VIRTIO_INIT: eth_virtio_pci_init(): Failed to init PCI device
> PCI_BUS: Requested device 0000:00:04.0 cannot be used
> EAL: Bus (pci) probe failed.
> testpmd: No probed ethernet devices
> Interactive-mode selected
> testpmd: create a new mbuf pool <mb_pool_0>: n=155456, size=2176, socket=0
> testpmd: preferred mempool ops selected: ring_mp_mc
> Done
> testpmd>
> 
> => the problem starts at the line "Getting a vfio_dev_fd for 0000:00:04.0 failed"
> https://git.dpdk.org/dpdk/tree/lib/eal/linux/eal_vfio.c#n966
> 
> FWIW, here is the output when it starts correctly:
> EAL: Detected CPU lcores: 4
> EAL: Detected NUMA nodes: 1
> EAL: Detected static linkage of DPDK
> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> EAL: Selected IOVA mode 'PA'
> EAL: VFIO support initialized
> EAL: Using IOMMU type 8 (No-IOMMU)
> Interactive-mode selected
> Warning: NUMA should be configured manually by using --port-numa-config and
> --ring-numa-config parameters along with --numa.
> testpmd: create a new mbuf pool <mb_pool_0>: n=155456, size=2176, socket=0
> testpmd: preferred mempool ops selected: ring_mp_mc
> 
> Warning! port-topology=paired and odd forward ports number, the last port will
> pair with itself.
> 
> Configuring Port 0 (socket 0)
> EAL: Error disabling MSI-X interrupts for fd 277
> Port 0: DE:ED:01:E0:1B:75
> Checking link statuses...
> Done
> testpmd>
> 
> Any help would be appreciated.
> 
> Regards,
> Nicolas

+AlexW

Thanks for the report and especially for the repro steps.  This sounds 
just like the one reported for the QAT regression also in this thread.

https://lore.kernel.org/linux-pci/aEmS+OQL7IbjdwKs@gcabiddu-mobl.ger.corp.intel.com/T/#m7e8929d6421690dc8bd6dc639d86c2b4db27cbc4

I'm traveling this week, but as your report doesn't have a dependency on 
QAT hardware I will try to reproduce next week to understand what's 
going on.

Alex - if you have any ideas please let me know.
