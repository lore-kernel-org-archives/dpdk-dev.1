Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161DBC02199
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:54:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B51340270;
	Wed,  5 Feb 2025 17:54:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 542FC40261
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:54:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738774468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCN52elOX6p6O8IOkKId/4O2haCVDajCoX0yaAHXdzY=;
 b=Igf3+ilXQd7MLaZ4qYU2jVT8JhiJ7Lft1AyA0fHJ/wRkyVyFkfbUhzANWpSu34+wbE2qFk
 PBifTl0a7dBWgp4/ntWNmSubtoCALuKjKugxLhU6hguMEsBVoFXxEdO6qFaOl2LyVv7z0/
 tGqYEuqFI2xMouaFGqdeZKcaMw+KTOg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-495Cia50OvCBUpCMuqL0xA-1; Wed, 05 Feb 2025 11:54:25 -0500
X-MC-Unique: 495Cia50OvCBUpCMuqL0xA-1
X-Mimecast-MFC-AGG-ID: 495Cia50OvCBUpCMuqL0xA
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-301b911c038so41464471fa.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738774464; x=1739379264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCN52elOX6p6O8IOkKId/4O2haCVDajCoX0yaAHXdzY=;
 b=D8RZZy4F67SSy0/zEcHjQ2z7XgZrMvdP90Ed2/4/slrwm6n+Vy7X3+a2hgBi9eIjHj
 RRNVCRn60/NPeF1gGgU5yJVcJlPYJ85rnAV6a/mN2XfxJ+sAIqQfknvWd8tdPhxXGB9M
 GTbnuBH4lqOuQj+TKQumRE6bgyvX5Zc3LdKj3iXw4FpjCfo5162KRLCbh4tzbdaH+jsL
 UPyvRQ+ayAD/1gCZCdNzJIGS8ioom0iAnT3XCLPNC97ZtcWOcYSrHBtDQWTnmTdv9sRd
 PAB/dvfJKLhEPDGVQLtk45Ll0mvE8GCemrnvP0U45qX+HOaPbv9XMUJQ0M0cw/an7cl6
 ouEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfBrXnQ5PNZ2ANQZWa8hQmc0mq5Xld9ZLyQ18PVfwYYzUAr+GvOpzsRR+cOJJNcI8xxE8=@dpdk.org
X-Gm-Message-State: AOJu0YwfNSuWjivQtTFzO0I5CkndtJKUnq5atR211etCOAd7FmfAl0EO
 QOHub85vNAs2MPxoJcmL9uBCV8oFOc8HLYToH+az9W69H1SzIqIouHHruAD0z6O8js2fqrnskjb
 kZOeE38JGMzlD6RcnpZuBzwZsrvvUVXH62G/Eh47vUd/Eh1zR7/b0jNnXmW3wl1HYk0Q6qikH6y
 PCfLVoPqKVgwL2fVOY5fzk/SyQPQ==
X-Gm-Gg: ASbGncsji1PABK99asczVPeupmfRPAGIjAZ4mHUY5om/EYLoT+I50G2jQqOGlf3s6xG
 HywkzwDv/RVak7RND80kOBSDw1Fn6wLJMJuZlqW4JIeluApBpa4KGW9mxOpG+dKTk
X-Received: by 2002:a05:6512:3183:b0:542:98bb:566d with SMTP id
 2adb3069b0e04-54405a19d75mr1465866e87.15.1738774464103; 
 Wed, 05 Feb 2025 08:54:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9DPABdc0D4jas/VXwtj4IqCpC2UWrVClJgUy9H2ekmSjqpd6yx939RlmU/2AzlMenRc5fe+enQxSkz2f8Bc8=
X-Received: by 2002:a05:6512:3183:b0:542:98bb:566d with SMTP id
 2adb3069b0e04-54405a19d75mr1465860e87.15.1738774463683; Wed, 05 Feb 2025
 08:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <2040007.zToM8qfIzz@thomas>
 <cd6b3b85-1356-4b59-a36a-c5ddb6ab4f64@yunsilicon.com>
 <3203749.TQGk6oTFT5@thomas>
 <71be3e4f-6411-48d4-bace-d27be9b94c17@yunsilicon.com>
In-Reply-To: <71be3e4f-6411-48d4-bace-d27be9b94c17@yunsilicon.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Feb 2025 17:54:11 +0100
X-Gm-Features: AWEUYZkLiSAwVJzmOVkDf27CW49NseSI-xCclOnKxvUi5qw4BwZSXnnaBDkLO88
Message-ID: <CAJFAV8yYnCP5AKJdPYQ5PcXR4vX135QbOxfqMqKA2hyREf=Y5A@mail.gmail.com>
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
To: Renyong Wan <wanry@yunsilicon.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org, ferruh.yigit@amd.com, 
 stephen@networkplumber.org, qianr@yunsilicon.com, nana@yunsilicon.com, 
 zhangxx@yunsilicon.com, xudw@yunsilicon.com, jacky@yunsilicon.com, 
 weihg@yunsilicon.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: czQ-7lKaW0cqHWSqyieJa2HIT3uWsUneH5K-hkUPuLI_1738774464
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Feb 5, 2025 at 5:44=E2=80=AFPM Renyong Wan <wanry@yunsilicon.com> w=
rote:
> >> That's how we designed it.
> >> We designed a low-level device operations framework named xsc_dev_ops =
to
> >> support both VFIO drivers and kernel drivers. Each xsc_dev_ops is
> >> registered before the main function runs. During the PCI device probe
> >> phase, the XSC PMD selects the corresponding xsc_dev_ops based on
> >> rte_pci_device->driver, therefore, there is no need for devargs.
> > I don't understand.
> > If both VFIO and the kernel driver are loaded,
> > we'll scan the device twice?
> > Will it be probed 2 times?
> >
> >
> No, it won't probe twice.
> I suppose that each PCI device will only be bound to either the VFIO
> driver or a kernel driver. The drv_flags of the xsc_pmd PCI driver will
> not preset with RTE_PCI_DRV_NEED_MAPPING. Therefore, in the
> rte_pci_probe_one_driver function, rte_pci_map_device() will not be
> called. After entering the probe phase of the xsc PMD PCI driver,
> rte_pci_map_device() will be called in xsc_dev_ops->init() based on
> whether it is a VFIO driver.

(side note, this means that this driver should probably call
rte_pci_unmap_device() in its release path, though I see none)


--=20
David Marchand

