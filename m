Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFB7CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 17:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 599A2402B7;
	Mon,  3 Nov 2025 18:07:22 +0100 (CET)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 12B20402B7
 for <dev@dpdk.org>; Mon,  3 Nov 2025 18:07:20 +0100 (CET)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-7833765433cso6122651b3a.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 09:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762189640;
 x=1762794440; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIcTTGWaOndMtplpEnppajgwximK8+wChWnLzaIDu+E=;
 b=NMpvNr/HB6RDR0O5YIf4Mj1ko8dbctazXRDIEGYFsiUpoqpLb8YmcYSqGKlXQEucdC
 SoA76tDioO5WDoEi3lJ9ZWAm3Aq5kbGRkvQwNgchKwdGCeT4vmkaHcfbEpPAqviPVe4q
 XCSt0CcyUJqcbCF+A5Uy0jsIEMZ5trUde4gnFZqVeCxRYJpasgg1ozWpqvrnlApU813k
 CEtoM4GuY3BKnxLutQC+K/os2QZqkMO0eoO/gQ0uMVvKPfjOFk8tKTAmc0+JAmg94Qln
 Ro8n+LoPH5YQJ+J0wO7hPk1VCxtgnxzwz7lH/H7TcRS6xOTgf6HeQA+pNpi3QNI58SYC
 8/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762189640; x=1762794440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IIcTTGWaOndMtplpEnppajgwximK8+wChWnLzaIDu+E=;
 b=js9BFRRlE/PyKuEBH22t/FGUeNuvhaYNrnhXmrakVRERA8N0HWF/aZBRoN16mZ55Q6
 6pLu3IRU/WHNwwVB/9HXKaA19G5DD1tkxjvYTcbwTxdNIAq4i+QKJwxOtDMjYPra0S8V
 dVIKhA/FcnD+M+sRaGojrTOIckMNdn2VyFfAh4sFh23hJHO8gcWSna4Z7Cl4Tjy9NZP5
 U+43wdHBoQhqHt55B4OapJNvZfPaot43NIUchDhVuapzP5m0yDV7J+F1pEi1udK7TvP3
 5NtLzyyvs4crEhBVvb6vROTPFvG4pGON6tDQWHhT9h2zKH64kCxklO0jSsxLY2oi5lTd
 ilxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOpj4ws409n9OWkdVlaRj9jQ/N5Gv6XRRAo3KpuKckBx2Gk9f24MY74TmKv9/zJrzY0wo=@dpdk.org
X-Gm-Message-State: AOJu0YyrrVpaRUwaQRCY99P/d8TELB1uCF9oHy8GrYHEVl+SDurfIxkS
 njL4e8CqkEw4ieSyRlDRWisrUTDXutqZdyZDpel7wJgwX0eTaUouHyhxNWjxeaEv9Nk=
X-Gm-Gg: ASbGncsnjXEyvgTcvuaGNmXwwqCgmi//EjxnnNEGwfFWyuD5XsnJGZ1cvzh26IwmTWt
 qeYXUldULMDCOGEU5FNbB9mTLS1yspmHZh4ksgxSkTxMjgphwW/NBMHJxqWzrvAE2VoGBU/XylP
 G3RWu/Jzc5C3e8sDqpiGcdai/tlIedK0dbEbYjIqBbEvdlnlySehi9DxE9w95VRy1GF4n3BHeVB
 8RmezfglXctV7UqK62STUfFkqed2vwbon+8ZkTE0vXMGBXdR5A0N5eH8mI/P2Xm/hUmAiB4gYAh
 et4G4V7itiFlfGPhloVOFGvY/oLe6Lbv4CJ2dneHeLr2s0ssz3I9j3jlkV1N5+HgCiEXuFhi196
 c6eAwOeJpBVluBv+6X8dN2WSHIXf+GTPJnHtpnYeQHWkJtkLxrtpp92Pb9pL6/gyDANjHZ0Qkfg
 9xO+bzfog9U1g1Bt/UP1qsygwILWnPv+3u9A==
X-Google-Smtp-Source: AGHT+IEngt9VovJAILNPCGlO7TZb+oYk30rMXRAYZbbct7v5XW6xUPe6S5PRvBWROkLu3wECe+d8uQ==
X-Received: by 2002:a05:6a00:b8e:b0:7a2:8d06:fa0e with SMTP id
 d2e1a72fcca58-7a77aac1eccmr16256576b3a.26.1762189639914; 
 Mon, 03 Nov 2025 09:07:19 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ab940156fcsm3373868b3a.22.2025.11.03.09.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 09:07:19 -0800 (PST)
Date: Mon, 3 Nov 2025 09:07:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, dev@dpdk.org, Ola Liljedahl
 <ola.liljedahl@arm.com>, vattunuru@marvell.com
Subject: Re: [PATCH 1/1] eal: correct memory ordering in MCS lock
Message-ID: <20251103090717.2d181d95@phoenix>
In-Reply-To: <f08a5a55-2a46-4f8c-9658-f7c320de57f2@arm.com>
References: <20251023184724.1759497-1-wathsala.vithanage@arm.com>
 <f08a5a55-2a46-4f8c-9658-f7c320de57f2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 3 Nov 2025 09:12:39 -0600
Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:

> MCS lock is broken, it's just a matter of time it will run into a deadlock.
> 
> drivers/dma/cnxk is a user of MCS lock.

I am surprised that a driver would use mcslock.
MCSlock is targeted at case of large number of CPU's with lots of contention.
It will likely be slower than spinlock or ticketlock for the use case of driver.
