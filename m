Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D7DCD98F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 20:59:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72B5540268;
	Wed, 17 Jun 2026 22:59:06 +0200 (CEST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id 5C11A4014F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 22:59:05 +0200 (CEST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so198651a12.2
 for <dev@dpdk.org>; Wed, 17 Jun 2026 13:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781729945; cv=none;
 d=google.com; s=arc-20240605;
 b=Iym0wkDpNaz13FnuUZwtB2HpT25/XMINvsaXDqPaKeQWwX0fKCZrYnJ1Dr21KD7qiz
 edi6qmx5MtNwJv7vQfWFoasduy8olYvkWPlYMFJVpt7UPO01FCAsgpMGFV+Ik/Z+VX3g
 FRzTAIs41MC0iDtipO2kcnibfMvo8Lh93Yj9CYe8kpRopGRnN0LZvxB5OWjnhHNapkMM
 PjNWWZSUcWTNZ/Yi/pBQP3RXiDKB/uytfjKhPZ+Bnu7eBx6im6EZ4xQpaatAmuNw4XMg
 P9nPOzeXkXN25tzReFPkdEBw/+YqTfoNtI3xi60VpP3uXqVsOYqQwb4gN2j+z8GoNZuI
 rrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+u0IY6034cegasjX2Kxa2FOK1NPBxjRuEW4QkcCh/xg=;
 fh=tFFzpJT+VQze+c0Fk1hAf94GKivIUVDEtEBIohu3aS4=;
 b=KV5UFIgzIVsbUc0S/YHFVt0loDFluiUuADX8NyluaW3zW/4oh1hE4qyCuZvcWX+Tv4
 Qdv3B5U57QZ3O6jlh/4TJ0d3CsF8rPK7t9dycbHgwqEMwbo41rPd48ZO6wQMVuqQB0gr
 i5S5yHxv7/ZWd8amyXe+7yFhcmajduaBJ26D7XrJi27SW/Cz3ZnBJrGtaoLgZKJ8PvsX
 VDJF2DwfPOcUjljkTL/y2gIVscNUebttUnWbVqwMDjvbaI3A617FaJ/opnmFeHsBt+5R
 wbhZBtPKk7c3Q5Vol6PTAQcjS/YL4HUPSn59Iu3NaKlfcDOfUjXsnp3cpfl7jWQTT+KB
 G8zg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781729945; x=1782334745; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+u0IY6034cegasjX2Kxa2FOK1NPBxjRuEW4QkcCh/xg=;
 b=hFTaBwGpyccITKx3esnDmanQxtWpNK20OLXlAWDZnybK11+FT0cPSQCYfeKgpw3Zi7
 xgr9G+gz7KKs9i4DKyghOGTj7WIDw2OJc6laa0WwVNPytGkVYEegS1fsPpE/7d01gTGF
 9m4ovsmfgcPHnFgDanLEEFEdUt/nnAIpBxaw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781729945; x=1782334745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+u0IY6034cegasjX2Kxa2FOK1NPBxjRuEW4QkcCh/xg=;
 b=q1dge94cFeiQOphTzA7dty19HKOBQIaqvN7vu6ouvIo0vPMuOWu7pkBrn2n38sc2zp
 sW78XrqcviI+Yi9y5ijYnxfj/8TwM+9bekT7rITJVhu5KRU0N6Za3oL/PN/H74MkEHdK
 k869gGdO1w8xoU18IyhrTyQcJOVYxGFGPoBPNGl1BsZX5YDtbn6xSF1yblY5WWUB+2cn
 MaZjt/filDGZfytSOEl7C6KNbpG2AXLYc6Uc756rnGEvJgZrrdLQpnkokn9KXPz8SW6f
 Z0s2l9CRiplO2KMfFy72rRtraqWaT4XKXWVeNOCEsId26/tOYdjd/Y9col4kgEhEft3s
 mQfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jiw+0Pxshsdf6Ce9A3FSTxLYdTlI94llqS8XR5Lrs87k0zYRDZCdSeuXAN0ATgm0O6gs=@dpdk.org
X-Gm-Message-State: AOJu0YwWBknqVIO50f+FdvFQwbk6ChQKqC6/IKmw6mrC3CYlMU9A7/Ax
 GDyQQrz+tfbwlj9N6aq5SNOQQOgoBEMgz4ZoiHTKo22THAp123cfiO3KGEVEIVaHl5Rf8w3VZPg
 QSFP8mRR0nz+NA09ZEG2psGZgD7vous8m7R9ETYqFrg==
X-Gm-Gg: AfdE7cmOE2UiFTChxaW1JnRou1m4TE7JjiWW6VdeI5NIWgMlCkcMM86aDENO/FkUSWL
 RmwdWpU09piidqpddWLktb3TCLeiOIPskTRT5tT4YP4edbCvJGV7hCAUiNhY4GyjdQ1kpf/+y97
 2TIK3efLc0qYIOlQzoSauzqkqx2xklzI73GKYoWfXI5TinMRV9GCG2ozKRaZUfAluh1Y3RBAlZf
 qZreYKmg2sX6KF7sHODLAKRXt2qUot1Uz8aaMkxqppTKAB+z8O8/R3wjOZrnlOmGTDq2hjPTClk
 SdohXAezAHMHUTMgOoMgyBXMQWhh/mo=
X-Received: by 2002:a05:6402:2696:b0:695:45eb:8ff4 with SMTP id
 4fb4d7f45d1cf-69547446844mr3411510a12.25.1781729944829; Wed, 17 Jun 2026
 13:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260518175424.253600-1-abailey@iol.unh.edu>
 <20260617155748.59724-1-abailey@iol.unh.edu>
 <CAK6Duxt3ZSCrHQyFp-n1OrEiWH7-4YNPzC8LP_U1HxvbouSwvg@mail.gmail.com>
In-Reply-To: <CAK6Duxt3ZSCrHQyFp-n1OrEiWH7-4YNPzC8LP_U1HxvbouSwvg@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Wed, 17 Jun 2026 16:58:53 -0400
X-Gm-Features: AVVi8CfshEXefYuPW-6-qZUExwgtze2e8_sFw5xkJRHlMyuQSx7rBK-rZftojf8
Message-ID: <CABJ3N2Wxr0wAmuF7FGThGgfssacuHQhgU7vs15rHh5dCedLdvQ@mail.gmail.com>
Subject: Re: [PATCH v5] dts: add retry loop to trex traffic generation
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: luca.vizzarro@arm.com, lylavoie@iol.unh.edu, knimoji@iol.unh.edu, 
 dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000072efd00654795478"
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

--00000000000072efd00654795478
Content-Type: text/plain; charset="UTF-8"

Thanks Patrick,

yes it was intel NICs having these link issues.

--00000000000072efd00654795478
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Patrick,=C2=A0<div><br></div><div>yes it was intel =
NICs having=C2=A0these link issues.</div></div>

--00000000000072efd00654795478--
