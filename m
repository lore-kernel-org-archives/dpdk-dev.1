Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBE3C678DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 14:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15275402EA;
	Wed, 11 Jun 2025 16:14:51 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id A1DD3402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 16:14:50 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3a4eb4acf29so79859f8f.0
 for <dev@dpdk.org>; Wed, 11 Jun 2025 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1749651290; x=1750256090; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NtPSxN3f/hSKLGrEdTW5DuLPmWgVBhZIqrCaEy4i/uw=;
 b=dZ8kF5H+tGv1hq6QOsTK1o0fnd1dleng9HTISen/qOLCdiX9+7LBdK7rLzru2ZbbkM
 iE55g1uKUDnsPjL4B+D5WsbpJlhwSDQ6RwTcUoYi3a5t/2FNzJnZxnXQUumdZ2usVeAa
 cOlJF4glfuT1RXLfrUI8Bc1lvIRaRKG7A5Bh1Su9FCj522SqEbGnq6DumrWRTFrqfgjV
 61gUTDjLpwhEzvQZXR40J20NugC1sEZfZe5msos1igW0cCQfLgWEa4s78Tq9jeHN7QH2
 PP5cPKeuuC/YYitRT8f5/P9VWQAS1H0DYt5FkSHr+z2MHDU2IvSpuaJe2vJ7w2Sd9xub
 Bplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749651290; x=1750256090;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NtPSxN3f/hSKLGrEdTW5DuLPmWgVBhZIqrCaEy4i/uw=;
 b=R1A2lST/vLW658dL5e3OgraO4gsOBEDg6SqiQ835+FVAzs3lDV6ClxqAcySrJeb5tv
 Ee5sXU/P8vwuuMOyDYCNDHNMxK8e747aExNXRdwXSDwKlpG63yGbWUDZD7imZ4AJ6D56
 9TPaKGb+jILSptTi0QliZQjhqjeOIAeVyKbcusxJee6zEV8TaZs9f02AkaOBwzUN50sb
 APlwlsW3zoZB9fIjmzBnWu0HjZ7scAqi3cxe+duvpNHX4/UPcW44uUpKqQZAYygu2t6V
 uvsUZJvjtImYU5fJLW51BYKWPnDikdg+OMk6mWdmleCrrXNVl/wb0ASkLqaFD0P5ZOEv
 ZTEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxNs0fvEBZc8CXUp5nti1ynAVQRXDLJoLWJJH9mCVH/IFtXOZRD4kI7IMzn1AIkaMm7kw=@dpdk.org
X-Gm-Message-State: AOJu0Yx0TerSjBE1JAgTBHFwEQX48aGE3QZ6SO6QLrlcX7W/rCZg6wYN
 O2NyKNRX5By0o4cA4Gd6tLNaLIBOKwOSWEaLuHyLUAtsZhBijh31jvnzoMb6HAprz7k=
X-Gm-Gg: ASbGncuQz0147KsFU++qb13+A3a0gsX6hrFXS7KgynA5ozBola4lXpyGZBuPcAxOzU8
 vAwbbKUMXXAF5cxY5F9BUFBN9wmYNNQBTKOaMUG8wz7vffTQfWYVaV1wvNjphw5wNLg7r8q+uqd
 3Q5IBUeR+YBIuSJveX7bnUGZuMLAN4hscoSwwp+QuPo184Hrbj2QafK6FueHDzMwogKwfNhyV2/
 qlWraWVCiN4pi2iJDH9JacQzMMKwCUXn/XO3MzdZEoUhQI5zNzuQSRs7xfycrd9jFnx0uEPMDjM
 TSEoh55lPOKzHnKlTg1atjRz92b7cEmMnc/twvtdOoD6eRUJJJrxaB7d8tT6Z7yfg8COUt2AOyL
 jezaRKKytEA7PWy4B3vVSffzm+C1GJlB+0fkhNMVHDb8lvgok5A==
X-Google-Smtp-Source: AGHT+IF5QjGtnTK3+avwKtK8lcdvBbTrsoW9iXv34rilJUfVk5XsaRgbij1H/xCqNfyhBwowL/oWNw==
X-Received: by 2002:a05:6000:2082:b0:3a4:da29:d13f with SMTP id
 ffacd0b85a97d-3a5586b89d0mr1076827f8f.3.1749651290044; 
 Wed, 11 Jun 2025 07:14:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:7f7c:5244:66f5:568b?
 ([2a01:e0a:b41:c160:7f7c:5244:66f5:568b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de53sm15349693f8f.8.2025.06.11.07.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 07:14:49 -0700 (PDT)
Message-ID: <3d09359f-6e38-4e48-9d4e-6bc203c49e61@6wind.com>
Date: Wed, 11 Jun 2025 16:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
To: Bjorn Helgaas <helgaas@kernel.org>, Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 rafael.j.wysocki@intel.com, huang.ying.caritas@gmail.com,
 stern@rowland.harvard.edu, linux-pci@vger.kernel.org,
 Olivier MATZ <olivier.matz@6wind.com>, "dev@dpdk.org" <dev@dpdk.org>
References: <20250505230632.GA1007257@bhelgaas>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250505230632.GA1007257@bhelgaas>
Content-Type: text/plain; charset=UTF-8
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
Reply-To: nicolas.dichtel@6wind.com
Errors-To: dev-bounces@dpdk.org

Le 06/05/2025 à 01:06, Bjorn Helgaas a écrit :
> On Wed, Apr 23, 2025 at 11:31:32PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> AMD BIOS team has root caused an issue that NVME storage failed to come
>> back from suspend to a lack of a call to _REG when NVME device was probed.
>>
>> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
>> added support for calling _REG when transitioning D-states, but this only
>> works if the device actually "transitions" D-states.
>>
>> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
>> devices") added support for runtime PM on PCI devices, but never actually
>> 'explicitly' sets the device to D0.
>>
>> To make sure that devices are in D0 and that platform methods such as
>> _REG are called, explicitly set all devices into D0 during initialization.
>>
>> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Applied to pci/pm for v6.16, thanks!
> 

I've a regression after this commit.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d4c10f763d7

I've started a QEMU with "-cpu host" on an AMD (AMD Ryzen 5 3600 6-Core
Processor) machine + virtio-net interfaces. When I try to start a testpmd (a
DPDK app), it cannot find the virtio port. The ioctl VFIO_GROUP_GET_DEVICE_FD fails.

To reproduce the issue:
qemu-system-x86_64 --enable-kvm -m 5G -cpu host \
	-smp sockets=1,cores=2,threads=2 \
	-snapshot -vga none -display none -nographic \
	-drive if=none,file=/opt/vm/ubuntu-24.04-with-linux-net.qcow2,id=hda \
	-device virtio-blk,drive=hda \
	-device virtio-net,netdev=eth0,addr=03 -netdev user,id=eth0 \
	-device virtio-net,netdev=eth1,addr=04 -netdev socket,id=eth1,mcast=230.0.0.1:1234

git clone git://dpdk.org/dpdk
cd dpdk/
meson build-static --werror --default-library=static --debug
ninja -C build-static
echo 3 > /proc/sys/vm/drop_caches
echo 256 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
modprobe vfio-pci
lspci
python3 ./usertools/dpdk-devbind.py --noiommu-mode -b vfio-pci 0000:00:04.0
./build-static/app/dpdk-testpmd -l 1,2 --socket-mem 512,0 -a 0000:00:04.0 -- -i

Here is the output:
EAL: Detected CPU lcores: 4
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: VFIO support initialized
EAL: Using IOMMU type 8 (No-IOMMU)
EAL: Getting a vfio_dev_fd for 0000:00:04.0 failed
PCI_BUS: Cannot get offset of region 0.
PCI_BUS: fail to disable req notifier.
PCI_BUS: fail to disable req notifier.
VIRTIO_INIT: eth_virtio_pci_init(): Failed to init PCI device
PCI_BUS: Requested device 0000:00:04.0 cannot be used
EAL: Bus (pci) probe failed.
testpmd: No probed ethernet devices
Interactive-mode selected
testpmd: create a new mbuf pool <mb_pool_0>: n=155456, size=2176, socket=0
testpmd: preferred mempool ops selected: ring_mp_mc
Done
testpmd>

=> the problem starts at the line "Getting a vfio_dev_fd for 0000:00:04.0 failed"
https://git.dpdk.org/dpdk/tree/lib/eal/linux/eal_vfio.c#n966

FWIW, here is the output when it starts correctly:
EAL: Detected CPU lcores: 4
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: VFIO support initialized
EAL: Using IOMMU type 8 (No-IOMMU)
Interactive-mode selected
Warning: NUMA should be configured manually by using --port-numa-config and
--ring-numa-config parameters along with --numa.
testpmd: create a new mbuf pool <mb_pool_0>: n=155456, size=2176, socket=0
testpmd: preferred mempool ops selected: ring_mp_mc

Warning! port-topology=paired and odd forward ports number, the last port will
pair with itself.

Configuring Port 0 (socket 0)
EAL: Error disabling MSI-X interrupts for fd 277
Port 0: DE:ED:01:E0:1B:75
Checking link statuses...
Done
testpmd>

Any help would be appreciated.

Regards,
Nicolas
