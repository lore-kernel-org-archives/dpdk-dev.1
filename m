Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF96BC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 15:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B851C402F1;
	Thu,  6 Feb 2025 16:15:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4A02A4029A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 16:15:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738854918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tflXWDwX/4NkSERa0pxRuzhNb59F/a2/weGKkvLCGE4=;
 b=OgaO1uNBtAxUX5pD9miL6tvr8rs1hCL0J3fhvL8GCbZ4qGFcdRDnf4RtmV4gjWrZHRyFbn
 cq1sldyTyzRIZTEw/T3UP/qGcYZMdajFBFVlSVWGNdpjnYBL5kRPXbheIVlZHcL0Chbnd/
 aFL5kc7nlnyxS7WWIw1JwMQh4hNOa5Y=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-G77HPqAPO3WdhUvuqd8zCw-1; Thu, 06 Feb 2025 10:15:15 -0500
X-MC-Unique: G77HPqAPO3WdhUvuqd8zCw-1
X-Mimecast-MFC-AGG-ID: G77HPqAPO3WdhUvuqd8zCw
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5440c445282so598108e87.2
 for <dev@dpdk.org>; Thu, 06 Feb 2025 07:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854914; x=1739459714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tflXWDwX/4NkSERa0pxRuzhNb59F/a2/weGKkvLCGE4=;
 b=gyIFbIB+Uo/g0wUgaxWKHXKejcVkKQRMJkMill2lJAWXxS0DJgPZSUF+XS+BQZR6tt
 YwRyLvaaH+XUngJfvtAIpvHF4saNN6cU12llSLfAbAb2nhSQvocK7cBqTR75PuMMDZVW
 jImF33AXLHC9aYBEIpGtJoBuW/C59bgL6MYOeJACROxTheBsHhb8E+yqv07j7BOd6nCV
 O00b+mQOH2tPtVvDyM/DmxdoX5jw/rUUy42Oz4rH0MY6291S+fkUinCMGQepEccIdbfa
 BH7DRUyJLjknlXwWuSwgsk/i22Xf3DhnNPwahi0atcVxHn2iIqPpRqcyH0+J75xk+HRC
 /RSA==
X-Gm-Message-State: AOJu0Ywq6q0rNd0J0C9tlm3QeQG9c7RRoYMIoe8gCPvcVmQmZwu19zNp
 qYTDVcHw92zX7+47juhLhhYbn/tL6e7HivAKhSd5mfJ/XvmKgEHIZCdq0nclnA4Lx1W9uKUHaoG
 luQ91Qi5tafoCSnsUKpE2sVbo1fFUb1QYmTuUnnywCpCryhEI6CReJPPwSXycJopUxMH6fIZSmR
 A8fDEcRC9I2mR89Ac=
X-Gm-Gg: ASbGncukb6X2upjcNqf/xpEwpv7SLX4InraZuFZZi5Q/N7jHz5naC91vBe4p1o+Zt5N
 47vX2c1Gk6kYHEvjjh/f1tyLsIXlV7PbRMBRK0g0vZkta+K0VbnHiD32CVblwB5pb
X-Received: by 2002:a05:6512:220a:b0:542:8da7:242f with SMTP id
 2adb3069b0e04-54405a10653mr2534279e87.10.1738854913980; 
 Thu, 06 Feb 2025 07:15:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAgpKDazhHIUnIE+g55VXBN2sCbfZ4KyLMuUFas3LgwCWZK/0pNOJLBiC38QmspoXb1iZrEDqqSF6Iozl7IT0=
X-Received: by 2002:a05:6512:220a:b0:542:8da7:242f with SMTP id
 2adb3069b0e04-54405a10653mr2534273e87.10.1738854913606; Thu, 06 Feb 2025
 07:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20250206084154.2230766-1-maxime.coquelin@redhat.com>
In-Reply-To: <20250206084154.2230766-1-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Feb 2025 16:15:02 +0100
X-Gm-Features: AWEUYZmn1x1TyTV9mJUyDEQWOLEI4x7lWpUbIaUAuXjsLVUwjrkfvQsh-wacqjs
Message-ID: <CAJFAV8z5XxM1o3pzKryFTfTFpTmPocUoApY0=2wY+xVJ1bChBg@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix FD entries cleanup
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bsyi40MVSBH1fZQNee75RSc0CaWWykIRXfs2wt3_88k_1738854914
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

On Thu, Feb 6, 2025 at 9:42=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> With the recent rework of the FD manager to use epoll,
> an error message is emitted with Vhost-user at FD entry
> removal:
>
> ERR|VHOST_FDMAN: could not remove 102 fd from 101 epfd: No such file or d=
irectory
>
> It occurs because the read callback closes the file
> descriptor before it is removed from the FD set.
> This patch defers the close() after the FD entry is removed
> from the set.
>
> Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

LGTM.


--=20
David Marchand

