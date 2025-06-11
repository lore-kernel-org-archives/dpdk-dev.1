Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6573BC71133
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 16:05:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42361402EA;
	Wed, 11 Jun 2025 18:05:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3574B402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 18:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749657930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GpGM+QQvMyhI8dzZkRGDrY/6eksryi19XUSVTg/eINQ=;
 b=Z6T3IaZ6OECM2OQCLmPvDPVOGcA1V4cfyoQXbbnNs73G8BSPR+o8F6A2L/KcrupUkgrRf9
 n35iO7CMRHn0YbCMxjpMFGsVeTScEkGThbIMQ/Zyf/uVOK3q6IX9kzFvm7vrR+02Hpq9rc
 jykXLayyLSxMibS+jWGNapZYXlBKPEw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-P1-A4_xOOgqs5eHTY06dVQ-1; Wed, 11 Jun 2025 12:05:27 -0400
X-MC-Unique: P1-A4_xOOgqs5eHTY06dVQ-1
X-Mimecast-MFC-AGG-ID: P1-A4_xOOgqs5eHTY06dVQ_1749657926
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-864456fddb1so345139f.2
 for <dev@dpdk.org>; Wed, 11 Jun 2025 09:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749657926; x=1750262726;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UOTzSx3hSNNW9qYVbicslBj/vCuzGZpIcZF1g4ZeIbo=;
 b=VS75Zk4XalJqoIz7hfDOOkMepCqjULvw5WG8WyP74rDXbRS3/hL0NHxgeEyeczlL6e
 wjc1BiCSFZjIXCJlj32ix6+3RtrpqNv7OP+3J2AssEHhIZumJEOU1zRKWgTIqMDGBbYU
 QiHgE1lxYwzoH+JF93fLSTtJyZc2C286S/v9Nwx2VaqEftd/zqV47mOqs3f1E1VdYZLw
 sYeC9ZtvsXmO64a0JzxNhWl3+zb03InVeggWQmwnzjYRn/3SiDJZ/GcyqA6hGIbEIpUs
 YUbCCBl4Sn3t4YgK71WMOIxu1c0oYwaGn1FdTTfNrstT2LrwzjbCsF+TibQC7v5fQj8b
 6H7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoNoeOTdjrRl5KXZf8WdYiE8w7ghmGPTzbShbYOy/Y4VbMKwtGVBqJa4/naeNNAa7Ut88=@dpdk.org
X-Gm-Message-State: AOJu0YyxicBSnQMWwQ7y3jVAaccKjZE8jYkBpgknasllPO1bvsUmICpD
 e/GubMslEjYbk/ZCMGEcTR6VmTc4H51hvOpZmWZ2CMaH/GwdsU7jdBcuZpTM4G8YY+B9+/FeVc9
 yadCgKie3HMtAK+p3aKVs6qL6QmTenQnX1E+ulwaUGoPQ
X-Gm-Gg: ASbGncvpgsJqHJ9c4XraDGGgl+07V0B9SSTbtFw4fiuJQ+myhfqKfFmeeh6vyNF3wBy
 5kc0hGJ1h+IsKEOn7RiLlIeatzC7nwuWNe7xKqcjEfHsvNkHsc6NQZD/8r/QzAF/JWO9cbUXCLf
 3oMrSVBFkz1KXnHW2X+tzB1P1+IXz5Gl8+SjFSH5IpksKaRJEkq3j8rjTR8uo8BpjGmbUeR8BVS
 NtAF4R0ssQ7srmCMdET4xxybWfh3DebtmgG+6c84lVpQnRRQtHtsxKNYd5WzLfvpWJT8FUYMPkt
 wXXDCJAGBj8zRqsow1A+y9mddw==
X-Received: by 2002:a05:6602:6014:b0:875:9e30:c7db with SMTP id
 ca18e2360f4ac-875bc517116mr141141439f.4.1749657926420; 
 Wed, 11 Jun 2025 09:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWthR/cqEpKFTBkDmPTXiCl5jV+NKEZWEqCTysLuWW1Llf9gUeFIONlY160WVMHcjQbqIxvQ==
X-Received: by 2002:a05:6602:6014:b0:875:9e30:c7db with SMTP id
 ca18e2360f4ac-875bc517116mr141138239f.4.1749657925823; 
 Wed, 11 Jun 2025 09:05:25 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5012aaf7b15sm438881173.144.2025.06.11.09.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 09:05:24 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:05:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: nicolas.dichtel@6wind.com, Bjorn Helgaas <helgaas@kernel.org>,
 mario.limonciello@amd.com, bhelgaas@google.com, rafael.j.wysocki@intel.com,
 huang.ying.caritas@gmail.com, stern@rowland.harvard.edu,
 linux-pci@vger.kernel.org, Olivier MATZ <olivier.matz@6wind.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
Message-ID: <20250611100523.5b5bb99b.alex.williamson@redhat.com>
In-Reply-To: <f81db934-5109-4e6e-aebb-7b874f98329f@kernel.org>
References: <20250505230632.GA1007257@bhelgaas>
 <3d09359f-6e38-4e48-9d4e-6bc203c49e61@6wind.com>
 <f81db934-5109-4e6e-aebb-7b874f98329f@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n6jZ-hcxJcrJpj8_P9FFsVoIepPhWOKgKuCj2PSeqMc_1749657926
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 11 Jun 2025 07:56:21 -0700
Mario Limonciello <superm1@kernel.org> wrote:

> On 6/11/2025 7:14 AM, Nicolas Dichtel wrote:
> > Le 06/05/2025 =C3=A0 01:06, Bjorn Helgaas a =C3=A9crit=C2=A0: =20
> >> On Wed, Apr 23, 2025 at 11:31:32PM -0500, Mario Limonciello wrote: =20
> >>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>
> >>> AMD BIOS team has root caused an issue that NVME storage failed to co=
me
> >>> back from suspend to a lack of a call to _REG when NVME device was pr=
obed.
> >>>
> >>> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-state=
s")
> >>> added support for calling _REG when transitioning D-states, but this =
only
> >>> works if the device actually "transitions" D-states.
> >>>
> >>> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PC=
I
> >>> devices") added support for runtime PM on PCI devices, but never actu=
ally
> >>> 'explicitly' sets the device to D0.
> >>>
> >>> To make sure that devices are in D0 and that platform methods such as
> >>> _REG are called, explicitly set all devices into D0 during initializa=
tion.
> >>>
> >>> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PC=
I devices")
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com> =20
> >>
> >> Applied to pci/pm for v6.16, thanks!
> >> =20
> >=20
> > I've a regression after this commit.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D4d4c10f763d7
> >=20
> > I've started a QEMU with "-cpu host" on an AMD (AMD Ryzen 5 3600 6-Core
> > Processor) machine + virtio-net interfaces. When I try to start a testp=
md (a
> > DPDK app), it cannot find the virtio port. The ioctl VFIO_GROUP_GET_DEV=
ICE_FD fails.
> >=20
> > To reproduce the issue:
> > qemu-system-x86_64 --enable-kvm -m 5G -cpu host \
> > =09-smp sockets=3D1,cores=3D2,threads=3D2 \
> > =09-snapshot -vga none -display none -nographic \
> > =09-drive if=3Dnone,file=3D/opt/vm/ubuntu-24.04-with-linux-net.qcow2,id=
=3Dhda \
> > =09-device virtio-blk,drive=3Dhda \
> > =09-device virtio-net,netdev=3Deth0,addr=3D03 -netdev user,id=3Deth0 \
> > =09-device virtio-net,netdev=3Deth1,addr=3D04 -netdev socket,id=3Deth1,=
mcast=3D230.0.0.1:1234
> >=20
> > git clone git://dpdk.org/dpdk
> > cd dpdk/
> > meson build-static --werror --default-library=3Dstatic --debug
> > ninja -C build-static
> > echo 3 > /proc/sys/vm/drop_caches
> > echo 256 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr=
_hugepages
> > modprobe vfio-pci
> > lspci
> > python3 ./usertools/dpdk-devbind.py --noiommu-mode -b vfio-pci 0000:00:=
04.0
> > ./build-static/app/dpdk-testpmd -l 1,2 --socket-mem 512,0 -a 0000:00:04=
.0 -- -i
> >=20
> > Here is the output:
> > EAL: Detected CPU lcores: 4
> > EAL: Detected NUMA nodes: 1
> > EAL: Detected static linkage of DPDK
> > EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> > EAL: Selected IOVA mode 'PA'
> > EAL: VFIO support initialized
> > EAL: Using IOMMU type 8 (No-IOMMU)
> > EAL: Getting a vfio_dev_fd for 0000:00:04.0 failed
> > PCI_BUS: Cannot get offset of region 0.
> > PCI_BUS: fail to disable req notifier.
> > PCI_BUS: fail to disable req notifier.
> > VIRTIO_INIT: eth_virtio_pci_init(): Failed to init PCI device
> > PCI_BUS: Requested device 0000:00:04.0 cannot be used
> > EAL: Bus (pci) probe failed.
> > testpmd: No probed ethernet devices
> > Interactive-mode selected
> > testpmd: create a new mbuf pool <mb_pool_0>: n=3D155456, size=3D2176, s=
ocket=3D0
> > testpmd: preferred mempool ops selected: ring_mp_mc
> > Done =20
> > testpmd> =20
> >  =20
> > =3D> the problem starts at the line "Getting a vfio_dev_fd for 0000:00:=
04.0 failed" =20
> > https://git.dpdk.org/dpdk/tree/lib/eal/linux/eal_vfio.c#n966
> >=20
> > FWIW, here is the output when it starts correctly:
> > EAL: Detected CPU lcores: 4
> > EAL: Detected NUMA nodes: 1
> > EAL: Detected static linkage of DPDK
> > EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> > EAL: Selected IOVA mode 'PA'
> > EAL: VFIO support initialized
> > EAL: Using IOMMU type 8 (No-IOMMU)
> > Interactive-mode selected
> > Warning: NUMA should be configured manually by using --port-numa-config=
 and
> > --ring-numa-config parameters along with --numa.
> > testpmd: create a new mbuf pool <mb_pool_0>: n=3D155456, size=3D2176, s=
ocket=3D0
> > testpmd: preferred mempool ops selected: ring_mp_mc
> >=20
> > Warning! port-topology=3Dpaired and odd forward ports number, the last =
port will
> > pair with itself.
> >=20
> > Configuring Port 0 (socket 0)
> > EAL: Error disabling MSI-X interrupts for fd 277
> > Port 0: DE:ED:01:E0:1B:75
> > Checking link statuses...
> > Done =20
> > testpmd> =20
> >=20
> > Any help would be appreciated.
> >=20
> > Regards,
> > Nicolas =20
>=20
> +AlexW
>=20
> Thanks for the report and especially for the repro steps.  This sounds=20
> just like the one reported for the QAT regression also in this thread.
>=20
> https://lore.kernel.org/linux-pci/aEmS+OQL7IbjdwKs@gcabiddu-mobl.ger.corp=
.intel.com/T/#m7e8929d6421690dc8bd6dc639d86c2b4db27cbc4
>=20
> I'm traveling this week, but as your report doesn't have a dependency on=
=20
> QAT hardware I will try to reproduce next week to understand what's=20
> going on.
>=20
> Alex - if you have any ideas please let me know.

Note that this instantiation of the virtio-net device creates it as a
non-PCIe device, where QEMU only seems to create a PM capability when
the device is exposed as PCIe.  Therefore this could also be a
manifestation that we've made pm_runtime initialization dependent on
the device having a PM capability.  Thanks,

Alex

