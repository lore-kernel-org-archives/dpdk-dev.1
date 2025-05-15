Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD95C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 10:32:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCCA5402DC;
	Thu, 15 May 2025 12:32:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1A4B340289
 for <dev@dpdk.org>; Thu, 15 May 2025 12:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747305125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RhSWSqq1qM2tf4/+myulPRArLzbgFCvpBNA7jr08S9w=;
 b=Mq8E9zYOGhkxOsqbEw1lcg3MiNBANmVCoMuQP0DFyvwUVWAfQl5VtJVhwNoeE31KCRMm0d
 WlZE21yXn8REqpctNZkPFU9IUPH5eXZRy8apIhqtMJuOt9nquhykhFXGLRlGs1jD9wDE0D
 dB4Rl1Bhg5YU3lzmlmqQWf2pas+PnpA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-KMpX4IE4NQW9HKhhAhukXA-1; Thu, 15 May 2025 06:32:04 -0400
X-MC-Unique: KMpX4IE4NQW9HKhhAhukXA-1
X-Mimecast-MFC-AGG-ID: KMpX4IE4NQW9HKhhAhukXA_1747305123
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso6962655e9.0
 for <dev@dpdk.org>; Thu, 15 May 2025 03:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747305123; x=1747909923;
 h=user-agent:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zCz3iwscsXq7F2KJaQ159kv73wrg7H5YMwkFrMleP0Y=;
 b=rFRn0yaewq3EdWpzfaeQzeWK9/6gdfp9xBkKnk8yA2JlKOThUtsy6a9mefgeDJ+1HL
 W8Sl9Bvtrv4/WGcIwKwAHA4yb0eRUot0V9OD2xDuOZPpEzzcigIl8wMSz8bZKiHLZ6A6
 f37nOG85FDrLu1ImVY+w8AfltBFAoisnA/1AMxgGYjJSbUPFyzJi6BJ6hAcb2uDJujER
 +H1PRHVONa7Oygp02WB5n7Y2l5IBrm9HoJOz9jq22FKretYEasjtN6XUHZrv1O+JWJSW
 S5EkolfBmPbkhU6NTuVyUd0wgc/HP0KJvIy2nQWNoEMg8YTRk/AsY9dTC0Gp3HrCaTvQ
 WCwg==
X-Gm-Message-State: AOJu0YzXCwrVZtcr/6QSOE5Xrols7xhy19c68pHILcVEAr34/xkh9Y5V
 FXHBrDUCWtZASCgYne/k08nMPf32m4zD74Vh8tLRh6NsoL4b4F6HS39RoNnpqXdUrPbKPqWS8U+
 BLKWzlGqFw3TwI4oE577USaSKQkPX4IWqvwuP7kdiYSSVmGtyKYO2y7mXWnzweEXF8xuu6JgU93
 Sli2yIHGp6opCQgaP9buDRJiea
X-Gm-Gg: ASbGncs0hpxSgeRriVLOCddBisFuoQTrBsfw8Ks0/SD9hQE873z2iGaqH6eyoUnScgo
 mmUTXams7kEvoiJFfRXleJDVLbMqYgcC6MyWs1usgfFCgaHpFU659cLPUfaHla9wMT9OgxjX3E1
 R/7Fak5Ep/X3ld7pD77ojOC9PvRSgp0WYZcme0etY2InMJYDtl6ebTOKxya5PWUocWIgORFzN1c
 FCXiTXuCdLdUuTbTV3zDJEL8f1wQ9ITHHScedMTm6j4ZdLyg7r5db7Q7dc7VCIspilav80TaULj
 +IsIzLGxBG0mplMLXKf6+mHoymOebKl34FvKIi7ru6Fe3x4dWZOMznP31z9l0pXyPXfL
X-Received: by 2002:a05:600c:524c:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-442f20ba9f0mr55115205e9.1.1747305122852; 
 Thu, 15 May 2025 03:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1RiqCXAlkKiLcKEaibTPcOSIhHWsNHyeKyjQostmRfbiZa+H2+FI5zh4JyYuH+UXRfnx+JQ==
X-Received: by 2002:a05:600c:524c:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-442f20ba9f0mr55114855e9.1.1747305122358; 
 Thu, 15 May 2025 03:32:02 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39e851bsm65549515e9.28.2025.05.15.03.32.01
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 03:32:01 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 15 May 2025 12:32:01 +0200
Message-Id: <D9WNYZDZHISG.3091PEP8Y34QL@redhat.com>
Subject: Error with --no-huge when compiled with -fsanitize=address from gcc 15
From: "Robin Jarry" <rjarry@redhat.com>
To: <dev@dpdk.org>
User-Agent: aerc/0.20.1-81-g060a0fd5ab70
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y5fQd1BGxEPLR_bdCVlU7x-qxGegedNAeLBm7Upa9kA_1747305123
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Hi folks,

I recently updated to Fedora 42 that comes with GCC 15.

When building with -fsanitize=3Daddress (libasan.so.8), it seems that
the --no-huge mode (along with --no-shconf) fails at initialization for
some obscure reason.

"couldn't allocate memory due to IOVA exceeding limits of current DMA mask.=
"

I have looked around everywhere and I don't see how to get around this
issue.

It is working fine with GCC 14. Maybe some changes were made to libasan
related to the address ranges exposed to the mocked allocation
functions.

Is this something that needs to be fixed in DPDK?

Here is a reproducer:

$ meson setup build -Dtests=3Dfalse -Denable_docs=3Dfalse -Ddeveloper_mode=
=3Ddisabled \
=09-Denable_drivers=3Dnet/tap -Denable_libs=3Dgso -Denable_apps=3Dtest-pmd =
\
=09-Db_sanitize=3Daddress
The Meson build system
Version: 1.7.0
Source dir: /home/rjarry/upstream/dpdk
Build dir: /home/rjarry/upstream/dpdk/build
Build type: native build
Project name: DPDK
Project version: 25.03.0
C compiler for the host machine: ccache cc (gcc 15.1.1 "cc (GCC) 15.1.1 202=
50425 (Red Hat 15.1.1-1)")
C linker for the host machine: cc ld.bfd 2.44-3
Host machine cpu family: x86_64
Host machine cpu: x86_64
...
Library asan found: YES
...
$ ninja -C build
ninja: Entering directory `build'
[259/259] Linking target app/dpdk-testpmd

$ ldd build/app/dpdk-testpmd | grep asan
=09libasan.so.8 =3D> /lib64/libasan.so.8 (0x00007fac50e00000)

$ rpm -qa *asan*
libasan-15.1.1-1.fc42.x86_64

$ build/app/dpdk-testpmd -l 0 --no-shconf --no-huge -m 2048 --log-level=3Dl=
ib.eal:debug
...
EAL: Buses did not request a specific IOVA mode.
EAL: Physical addresses are unavailable, selecting IOVA as VA mode.
EAL: Selected IOVA mode 'VA'
EAL: Probing VFIO support...
EAL: Module /sys/module/vfio not found! error 2 (No such file or directory)
EAL: VFIO modules not loaded, skipping VFIO support...
EAL: Ask a virtual area of 0x2e000 bytes
EAL: WARNING! Base virtual address hint (0x100005000 !=3D 0x7f9bc4cc1000) n=
ot respected!
EAL:    This may cause issues with mapping memory into secondary processes
EAL: Virtual area found at 0x7f9bc4cc1000 (size =3D 0x2e000)
EAL: Setting up physically contiguous memory...
EAL: Setting maximum number of open files to 524288
EAL: Ask a virtual area of 0x1811000 bytes
EAL: WARNING! Base virtual address hint (0x10000b000 !=3D 0x7b9bbeae5000) n=
ot respected!
EAL:    This may cause issues with mapping memory into secondary processes
EAL: Virtual area found at 0x7b9bbeae5000 (size =3D 0x1811000)
EAL: Memseg list allocated at socket 0, page size 0x4kB
EAL: Using memfd for anonymous memory
EAL: Ask a virtual area of 0x80000000 bytes
EAL: WARNING! Base virtual address hint (0x100011000 !=3D 0x7b9b3eae5000) n=
ot respected!
EAL:    This may cause issues with mapping memory into secondary processes
EAL: Virtual area found at 0x7b9b3eae5000 (size =3D 0x80000000)
EAL: VA reserved for memseg list at 0x7b9b3eae5000, size 80000000
EAL: memseg iova 7b9b3eae5000, len 1000, out of range
EAL: =09using dma mask fffffc0000000000
EAL: eal_legacy_hugepage_init(): couldn't allocate memory due to IOVA excee=
ding limits of current DMA mask.
EAL: Cannot init memory
EAL: Error - exiting with code: 1
Cannot init EAL: Cannot allocate memory

Does that ring a bell to anyone?

--=20
Robin

> Does not include installation.

