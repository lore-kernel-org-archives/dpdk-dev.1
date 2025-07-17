Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C18C83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 08:19:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B81C4021F;
	Thu, 17 Jul 2025 10:19:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 563ED400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 10:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752740380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5BJXjiOFJocpNVsi4NcabPetvR7k8KLxrPw/JEkgZPk=;
 b=a+J+ntFlSlLuBnuIE0RPTB8r0jk9KsTKv7mNOzGNz/iR6Ew50maJTJY0XGGPt6/ReEIIRh
 ED6KlAelFKbZEn40HM+7Na3pdHyrdpk0rqavrQ43yZEFe+1OWUpCprUteQkmHXG4wY98si
 lt+hL0mh7ZFz3+wFSDYszLqqGMffmnU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-a-IVzuXDP7-EPIIgLBunhw-1; Thu, 17 Jul 2025 04:19:39 -0400
X-MC-Unique: a-IVzuXDP7-EPIIgLBunhw-1
X-Mimecast-MFC-AGG-ID: a-IVzuXDP7-EPIIgLBunhw_1752740378
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553ab0afaa4so382117e87.3
 for <dev@dpdk.org>; Thu, 17 Jul 2025 01:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752740377; x=1753345177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5BJXjiOFJocpNVsi4NcabPetvR7k8KLxrPw/JEkgZPk=;
 b=vr+HbN3Xbpckaq/XudvmgB33QQOX7xfARZiF5ZyvH+NRUGMsZMNEVKQFGGdUrBOOZL
 rJvDwcbJn09d2AS2WXwsmyGVNx4nHid2XrFjJdqK8txGxk+Nli9XB0fXJRBkLyEdIMZ7
 9m5fzIyC2Gv1ejQHi+SFrmkA7dI/xWWw62MCLtUDJre1XrXWua6FJee/weuer7DiSgj0
 M6OYWTcnIKU15z91nToX2U34rvY3vzMVNMYWtERWaOTTA+ThmEOH6i1RIP3l2WQK40SK
 DsVszDrCKDLVNQU2BTev1Q2JkUN0I17ur1yGZLWHdU1oGtjYbW2DpAjKKEEa0HQuZrid
 hXyQ==
X-Gm-Message-State: AOJu0YwiLid4mt9qu2ZpvKvtjhY3G2pacQGwChdyG+X7mh6d5cToJoaP
 tqdpsrgvivYMKybENEYF0o73nx4xo44puW9r8oJdTIFNDDeFQ6IJl8yVeR3vGI7a+Oitg6r3RXy
 wYwmB4A6WbYO6m1NWzcs78FLf5Nog2N92SJ/4dU4RlDrTCwY1iOgh6ZtlZGEIWtrfV4N16k1ePF
 y9ZcvWT4v6MmiU8FeY4wo=
X-Gm-Gg: ASbGncsoXcgbBymkZKdCQ/t/NaEd8jYQiNe2aElPVSStbEoyannFtFwU/yp2wjJrNCt
 zZYlzNWoFkSnH+Od6V7KyoaZMwb2IzNOSPqx0U+mploJqgD86MRsWPePYNYpOUhKB4YvkGMp30/
 SVIZf0rZTP4AAdK8Qqw1oePd0=
X-Received: by 2002:a05:6512:3985:b0:553:a60d:6898 with SMTP id
 2adb3069b0e04-55a23f8020bmr1617303e87.45.1752740377557; 
 Thu, 17 Jul 2025 01:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYq1Sj5UC5JU/NHMzZY7w0Yn234tNZ1GWdPO5MyxgZoBnNWHGosW/TDTDm5SWn/TGj6FzM1RMz0j5XJLxTkUI=
X-Received: by 2002:a05:6512:3985:b0:553:a60d:6898 with SMTP id
 2adb3069b0e04-55a23f8020bmr1617298e87.45.1752740377047; Thu, 17 Jul 2025
 01:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250716173922.688476-1-bruce.richardson@intel.com>
In-Reply-To: <20250716173922.688476-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 17 Jul 2025 10:19:24 +0200
X-Gm-Features: Ac12FXziyULeTKdvH6qwRP1OqfxGQlKMEwqycPkwmBlesfuiGE1Qn_hY-y-nJ0M
Message-ID: <CAJFAV8waeOp1euderd+t2VTfTfree-rratig_qq+eCGnJgTq5w@mail.gmail.com>
Subject: Re: [PATCH] net/ice: fix assumption about tag placement order
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2EV3ox_f3mS2xufcLtHGYB9fLkfM7ZLjlxGIoJ-hhXw_1752740378
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

On Wed, Jul 16, 2025 at 7:39=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The specific placement of outer/inner VLAN tags in E810 and related NICs
> is configurable. Therefore, remove the assumption that if the L2Tag2
> field is filled in, that the L2Tag1 must also be. Instead, check the
> existing mbuf VLAN flags, and move tags and set flags as appropriate.
> This fixes an issue where, with QinQ packets with different Tag ethtypes
> (0x88a8 vs 0x8100), we get an mbuf reporting two valid tags, but only
> having had one tag stripped.
>
> Fixes: e0dcf94a0d7f ("net/ice: support VLAN ops")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

The ice code seems copy/pasted from i40e.
So I guess i40e is affected as well.


--=20
David Marchand

