Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29365C54754
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 06:58:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D6D0402C2;
	Thu, 15 May 2025 08:58:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 48FBC402B3
 for <dev@dpdk.org>; Thu, 15 May 2025 08:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747292290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRH4Nl9pGdMZHuI2rlAq8B5ksF76YY5cpNXAOoYino0=;
 b=NkJhqcJxYsE4oWgpBN+RBumVO/O81gmM0uPOOo4gOutdKXafcppjRQ/tmBkJfsTuWeQu8w
 J2sZf2HrPrCOR6nV0KTud5qrSroEOAXd3OM/GvFdKrE5zDfuhKYaXPf4TMKob4dQIs1cIg
 f5he7uYxUkEoebI4vLKRKhwndj3oSHY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-pgJ1dzgzO-27NhcMBf0ang-1; Thu, 15 May 2025 02:58:09 -0400
X-MC-Unique: pgJ1dzgzO-27NhcMBf0ang-1
X-Mimecast-MFC-AGG-ID: pgJ1dzgzO-27NhcMBf0ang_1747292288
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-326cff18eb9so3246621fa.0
 for <dev@dpdk.org>; Wed, 14 May 2025 23:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747292288; x=1747897088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRH4Nl9pGdMZHuI2rlAq8B5ksF76YY5cpNXAOoYino0=;
 b=g0Osp+V6ystg7lBr5yr03My9f9dsf0hZ3b7gwghL5bO9ganUycCxwX2Zz69AK7EhT6
 HWxwp4VOnbda/qp4R4i3NJWvGmriDRELKXNFK59AuyBBKeBdbNQHqNQAudXc9AHVn/mZ
 MmHUtrCTKaiM9CZVZZg8wtOUGr/9Roj6k/NUVcQnX44WD9jUrTbNR3gycGxwkwPbPfGh
 qehR3sjj7JZXbb6HXykkGswKXJbGmCv3QLyAv8ycI/De5n1pVX53FYQ5bgTsw3qaQAAZ
 vqrQk7H6Zlkpgi5XRw1Fa5EtFWWQUpWu/fP35abcN65RJO2U+66jBmKOcaJNtJuFO7rc
 ZKsw==
X-Gm-Message-State: AOJu0YwOY7vu/4wfRpghdG01Vs4r6b//5I1ULlB04+gsPGSRIkAst/mP
 V2C4Ny1OkD+iiaqrCDWJ/244TVDoZ40QaZykQBHF6f7RjRf5l24ndyxbfNnNi29hraU9H8PaZVW
 +NxpBl7vSKsJpiwN98uxgcENEDXk3COtbzhUVAuoGa4LO/zN8cZVc5zAbSrzuJqS+ik4l+1eUUX
 fkqIe/PYmPmI2fPVk=
X-Gm-Gg: ASbGncteR2Nf5q7NTV2N3fpRr0akEMGUZ9Fke1v1/cpm4kPCwKGti5z7R64WMpG7SCw
 B6qoZuV8Zk6zL2eknEmgVDdG5Vi0Tb1qYbb/OlMa9WQckiPC2tU8qnILBu/jRaVDBrDnWY5c=
X-Received: by 2002:a2e:bc8a:0:b0:30b:ab00:846a with SMTP id
 38308e7fff4ca-327f843e7damr10020701fa.3.1747292287639; 
 Wed, 14 May 2025 23:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaAil2ySRhuRuaF/0lnVRtlXF7h1RG97BuIfhk5HfGMhncZv1fcoPFTd+G9CzXAgksFXDvK3ymzAtjHC50IiY=
X-Received: by 2002:a2e:bc8a:0:b0:30b:ab00:846a with SMTP id
 38308e7fff4ca-327f843e7damr10020601fa.3.1747292287238; Wed, 14 May 2025
 23:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250408171902.2833850-1-bruce.richardson@intel.com>
In-Reply-To: <20250408171902.2833850-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 May 2025 08:57:55 +0200
X-Gm-Features: AX0GCFsycngnJg20HhZV5w4fpqQzrCxlGNX9nVT6Axv-d-ci2aHHJGViwO2pUEI
Message-ID: <CAJFAV8xGA1_zrx84naoXd2aUzy2aZ4MqBTBUAEth0H4_jambOg@mail.gmail.com>
Subject: Re: [PATCH] doc/linux_gsg: remove note referring to old pkg-config
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p0ZyrDgB3rZdPvunuiT_uaQz6EWq3zKqYQJLQaYf-kY_1747292288
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

On Tue, Apr 8, 2025 at 7:19=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Latest DPDK releases no longer officially support RHEL 7 as a target
> platform, so remove the note about pkg-config not working on those
> systems.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


--=20
David Marchand

