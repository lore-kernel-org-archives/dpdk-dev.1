Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A6F53D6D
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 16:21:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B63F84025E;
	Mon, 16 Mar 2026 17:21:03 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 67EAE400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 17:21:02 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12732e6a123so1667921c88.1
 for <dev@dpdk.org>; Mon, 16 Mar 2026 09:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773678061; cv=none;
 d=google.com; s=arc-20240605;
 b=cVZvjiBhqmCnV190QXWONWDf39xBWGgQEeR/xziXe2hICXTikcNrS1sr+ouNOKembM
 d1qtqGynx8ANKl9nBSWYeN19XtlqO2GJlH+GvOulsXGnivbbAidntVCyv3s0+sfCfrFc
 RkpSx4DbE10OTTJbyli7afoLB/C2zqCl9mhcNUQNNTV4Lmop1JtOujJ96Lc4qP4qD7i/
 iFFrEvOnXMm0NL4qvrjQcSI6Z/LfE1BpmtS8nzYPeDCWHBs1xlBcODnOPrunU2XDG7bK
 JZDSsoUoxXGRStSkcYdojxyQjTx+EmNRxYOG7wD+UCYcp1UFk6OdPArkoa5UnYNOgg5X
 wTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FhbhsIRQfDXQmDNmTAJwErGMefn4gA/aDV/UfXOmlwI=;
 fh=TnaQSLo3e16j7m5WUfLe3mP+auRMup1cMc92tEgLqeA=;
 b=f8SOG4wpXuSk4RPTSjNpFjSYQ22JMSaS76w5jEs/p2WmqM0tm0FXr3HODP7PC3kHBk
 WoMprV+yEp8QIK5PwlIWBmkOueLdAHLBEI2m2Q1qDE7bM6pJAsBygTi7NhSl7OJOEI0c
 jE1iv0ihRIKeu11BGxP3WSVWWnQyCYmXjbdzycF+eZHOs16+OTYMJisgdU8XSfI65Enw
 tW6cedThmZDXIG5rSafJLVD5Ho3IIQrHiRRD/Id6XlrecREynbm3E6A/MYnhSYw4TzQ5
 MFGq8Zr4n1NUUxBPhZ6x71rhtjvHGX1TuiM76ntHq4euA8805/aYwvmv43vu6SNIa2vD
 9Llg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773678061; x=1774282861; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FhbhsIRQfDXQmDNmTAJwErGMefn4gA/aDV/UfXOmlwI=;
 b=St3Y5uQfs94SJUCXRfkevQ2yUvU8iWx4m2v62reg1MZBHUE//pH7oSY/vXzQCsOQFH
 DrkfFtnolqKaOaMEDVT6m8Iiq69UtF12CZ8a7Gfzqfnh9xp1fzXvjGxM7EbHp1v7AC0u
 eIa81eJPyxN83HuKoEwv6o0jvZ0uTJh/awkUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773678061; x=1774282861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhbhsIRQfDXQmDNmTAJwErGMefn4gA/aDV/UfXOmlwI=;
 b=dHU3GaZ5Xn/VXuqUaJEncrMTfAg20U04eTxY/HWhOaljpTC5Y4yqiiMgZ98POlIbpe
 GAtabVu3Q6sLJ3n0KW6W25EfSIM5C4kOfwRL77o/N3vaSXIsFzwkQoeDMgmGTPJsr/VG
 Pf3UKgYb/F9ntWxxp60rf5fIVJBWhWEy54pdfmpKDzZDQTzE2Tl+GhgVwtJSSUlK83lz
 wKr1/QYTN8lIEd04uNrOcLFajQ+GzumnHo0cP1W1qbubzKSHfBz3f9xs+fLvE0d+rA0f
 7EdhYdQ61zhgzuTtZci9amo8alYn/0ppRXdXXWecpez2Lgue5np92Fq8eHcpG/HljFLN
 nSww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTNuYqYzDIB483ZhXeSE7+EUF1S6hV1NOq46zkbuy9JJoA2jNTmV1J9nZTd42mZL2ihTU=@dpdk.org
X-Gm-Message-State: AOJu0YwO6c1fOWxyXcmzPU4t52K+MgE1fgvt/nn8xoEQbq5BYWdHKMJu
 cXG3TdFA5Cx32Piv3KpRHUcCPErtki2WTc89yxm11/AYMlz2u8mzrLW1G2rsVpuMVnhSrlB81gW
 Kg+oQs19dHERZ4i6441fvD3Ls7OEAIu3dyaFOVWsYfQ==
X-Gm-Gg: ATEYQzwErIy7rp4cqUPOc+q6CqaPU+UonPcBYetzuE8b+uN76g9AEBECuFypAAja6zi
 kTE+FZsYqVr2M/ucNio6auVptgA8ZSVck0kndlQHMX+pt9kzcKbNBY/bfHQXiaeqB+foKDL9v8m
 /DPuLoyXOYUfO1FNZuziUPiaZX04D2CmOy31j9Vr4w97NSXGvu4fnwgTZdZxgGYewMOyHqNspEf
 4x8Lnvk/Y0i1A88YbtzDYY0tefCrOWMNyYdZ2VptE+HczV6A7R4r/UoCQmkTESeOFYKmroeHKIp
 Y/RlibOZe/pqB/wBTgTRE8nKr6G0v6MNLj7lO0E5MPSAEbuMrAXbuQ==
X-Received: by 2002:a05:7022:309:b0:11b:ec5f:1c37 with SMTP id
 a92af1059eb24-128f3d5d20cmr6934462c88.18.1773678061279; Mon, 16 Mar 2026
 09:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260313155601.112819-1-dmarx@iol.unh.edu>
 <20260313182240.130379-1-dmarx@iol.unh.edu>
In-Reply-To: <20260313182240.130379-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 16 Mar 2026 12:17:53 -0400
X-Gm-Features: AaiRm523AZBSj6SWBd8QALl7cV6_ko2f5ZPhQfJsO_MPrZyRNzseSFpL4rKO6Go
Message-ID: <CAJvnSUAL3o4wGexM10Ymp0WvhSjmzR8vgBbQefxemiO1UFrmkw@mail.gmail.com>
Subject: Re: [PATCH v2] dts: update overall result pass/skip logic
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org, 
 Andrew Bailey <abailey@iol.unh.edu>
Content-Type: text/plain; charset="UTF-8"
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

Recheck-request: github-robot
