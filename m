Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E274CFC294
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 16:57:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F031F4026F;
	Fri, 21 Nov 2025 17:57:35 +0100 (CET)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 7BC3840267
 for <dev@dpdk.org>; Fri, 21 Nov 2025 17:57:34 +0100 (CET)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-bc09b3d3b06so1213205a12.2
 for <dev@dpdk.org>; Fri, 21 Nov 2025 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763744253;
 x=1764349053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4R7KcMXgmiKqaGXXu4uicN5TK4LGgShRYc2UEHhXrp0=;
 b=H8i9P4uWBF4CNa2Kz7E9KMQXkhaLTtE5gIYwqlFvzRT2Dti6PeH9n/V3zXGUx4IVWU
 TzTPxqM0VDaL0au6QUBu5Z2iSVlZnCkFK3GaTJgHH+5VuOiQu0D2cewwfBTAxxATGU8J
 lyNcK5AsMyamTubH5iD6vZ+Ak6nR/PV8XktCNQ6GPRCc2EzJNik1pOPP9ZXsQfcUcrM4
 +wHFm3rfehoNtdkkyHvw2xSoFLvTZD5KYF9i/h0YYvco5rWoKS+RNd4HWgLaeQvWxass
 NzG8izdB94/7yDxXVTC4N/sA5jSQ4RLwnCE0Hi16FEFZZYp4Ur9FZ8MF3LfdT0PiViHK
 aJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763744253; x=1764349053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4R7KcMXgmiKqaGXXu4uicN5TK4LGgShRYc2UEHhXrp0=;
 b=lEJGIENirSo3+urPg9+ANOKWcxFCUkzncmrGGgVbN88YoNFuODXsGSqP0r7jRxh0vq
 0zFaJVM2sIu12jXbPhFCwd5X1kZPoldlz1msCi8BnfRRlnLOZk2+EJ18wfUsqih23hgG
 jMP33CHIBlPbs36Jc2wJPJXnEtrAyG0H3AmJwilR1p+lfo6f05H9nIIkYvuioHlzj392
 nF9rIkW02cSDblPDQxocXTJZbKqAiivaV/op37jZFUy7xMqt43DvqcMPvuAFNiriw95e
 D6L7fo26vxmXcRnDzco5JDIZ+RO9qQmnKDKSGcHj7RQVywGIYd0eqRh5nYtjsbObdrSM
 1EEQ==
X-Gm-Message-State: AOJu0YwTqjoNdriVNNFfJYFdvOtCpmCF2h4nJYXzZw6spBIaVgPKc7h8
 bSVaPPLkicIVjqAR75op8Z/TlXML2xpA9MhACU+Xgy9udGQAkAtESi07sD7rEg7ifRw=
X-Gm-Gg: ASbGnct4inhAKxXlDWI4fkf1J/rfFxUuOvlaeMjQ8wkywEw4dMG5W38rZKEcYpH48cH
 t8YPOxgi4jwIagAJFKFquZhuOjNcQeQm0mNQaGc7YLRMXXQl5WLPDccj4akIn/LkYU9fWsGnG4Q
 1pSn7M7kQm75oyoxTyPCIxe8KB5bK4MLqL3WeOVorZcvbFSFKhyxVRo+NsURSpMd4efW63tlgy5
 EtuuDBfHSDzgrx4m//eyN0zhVD/Gb/9XoX7yKFcAHsBpyI8z+jg+oZ1fbzWk/hMyDH6PEtDzDdV
 yjT3X6YVfNbsqEt9NWRAEJOZ3BWddcNRDo3XAA/HAWqdA6RGrlqBbDxKPE5MigEwB2ipyt801tP
 Fx58H3xyKjTwU2ADw5Eez+W1n6AlTOFX08S8X++6GGuiD3str7Hhfbr38ycZ+c4wew1X2Va2J5S
 fXayeO0v0QCoY4k3dzI8erlP4TNSXNXLk/ArXIimevF4DdZW/vFtek
X-Google-Smtp-Source: AGHT+IGHPamxg/lYYsfe1KJL14p0DZ3epM8n225E11D2aPYCkk7QAskaioMS39UV74aohUyT3g703A==
X-Received: by 2002:a05:7300:4f19:b0:2a4:3593:4674 with SMTP id
 5a478bee46e88-2a719127887mr875464eec.16.1763744253217; 
 Fri, 21 Nov 2025 08:57:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93db556csm25219732c88.1.2025.11.21.08.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 08:57:33 -0800 (PST)
Date: Fri, 21 Nov 2025 08:57:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Konstantin
 Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin Varghese
 <vipin.varghese@amd.com>
Subject: Re: [PATCH v2] eal/x86: optimize memcpy of small sizes
Message-ID: <20251121085730.51f0466a@phoenix.local>
In-Reply-To: <20251121103535.1273457-1-mb@smartsharesystems.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251121103535.1273457-1-mb@smartsharesystems.com>
MIME-Version: 1.0
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

On Fri, 21 Nov 2025 10:35:35 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> The implementation for copying up to 64 bytes does not depend on address
> alignment with the size of the CPU's vector registers, so the code
> handling this was moved from the various implementations to the common
> function.
>=20
> Furthermore, the function for copying less than 16 bytes was replaced with
> a smarter implementation using fewer branches and potentially fewer
> load/store operations.
> This function was also extended to handle copying of up to 16 bytes,
> instead of up to 15 bytes. This small extension reduces the code path for
> copying two pointers.
>=20
> These changes provide two benefits:
> 1. The memory footprint of the copy function is reduced.
> Previously there were two instances of the compiled code to copy up to 64
> bytes, one in the "aligned" code path, and one in the "generic" code path.
> Now there is only one instance, in the "common" code path.
> 2. The performance for copying up to 64 bytes is improved.
> The memcpy performance test shows cache-to-cache copying of up to 32 bytes
> now typically only takes 2 cycles (4 cycles for 64 bytes) versus
> ca. 6.5 cycles before this patch.
>=20
> And finally, the missing implementation of rte_mov48() was added.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

As I have said before would rather that DPDK move away from having its
own specialized memcpy.  How is this compared to stock inline gcc?
The main motivation is that the glibc/gcc team does more testing across
multiple architectures and has a community with more expertise on CPU
special cases.
