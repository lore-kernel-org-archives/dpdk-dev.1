Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE89CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 08:58:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9B4D40272;
	Tue, 13 Oct 2026 10:58:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DDB38400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791881902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NjOlsmcqtkj/Mgm2Ul0WVwN3+ICRw5og/CsWlYW0Xkc=;
 b=aaO5DFSOACepO+eXdIIbg94uEiKixL+iyCndfWgnFLAsAQzBqdmIysRJIcfhNSee+44U4T
 W6qLzCoAeYkj8jluLMMoGPA0rDAf8pQ7gAMpkrDb2gwoXQ3gVhogG9AZPALDv7Hhz0r742
 f5CplvINVIsXZgVfmN7MZoSCLcTQQhs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-qlSI_KSGNZK41ccHZjcbKA-1; Tue, 13 Oct 2026 08:58:20 +0000
X-MC-Unique: qlSI_KSGNZK41ccHZjcbKA-1
X-Mimecast-MFC-AGG-ID: qlSI_KSGNZK41ccHZjcbKA_1791881894
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5bcf39533ebso1225812e87.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 01:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881894; x=1792486694;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NjOlsmcqtkj/Mgm2Ul0WVwN3+ICRw5og/CsWlYW0Xkc=;
 b=r+FPhfrjnSdkHeFEpPRs2mPk7o0sQWoLtnK64sij3XhIYZistQRLhkvyZOg2QVfx2p
 J/skL2Wn2pcTCQBH77iOUVsp/5K3Oos+ywFD3SZbHaIQzeM0EeORTUoWYy3ySYwJTYlQ
 /GK6DUZMHM++qbf91sgLjU9vbEtVKeYxt5h3tC7H7Nrp9oVOQ+y3XJ1yjht8sc9vwPTZ
 GlaH3JH672Zib9yPCZh+3PwiEHZl6C7J55Kl4ujitvVYdbO71cTwT1ve79RuJC1zklZw
 V1Q2pAFYNXIF1ZlhnQFJX7C3ioj3LjUKOtW5FT5FUCNF6CvxIWEW4TJHLgl+LRthdaNj
 u+6g==
X-Gm-Message-State: AFq9FYIwLixGovuG7MBvU3vsQUrOJEDOV6IpDttDCgnUab1n1Tl5pGi4
 GiuHkJ9OcDlHNPD2/PHGC5rhkZY+uh05aR4d4u2xmnr7ObbzSXbBl2+MDQXi2UiWZAGovg0VMN4
 2g6+a5RhWCVW1vtdGOdBXtLOd7/rBq8a37HLutUaCd4JIUkU6487y3N7o2nyNLLB7UEHQFdctkx
 zviGFD92z9Vt3iXpc+oXg=
X-Gm-Gg: AYBFou3uHypxZ2cEgzDqxR6+HcW17KFwkHUDmjRGWedo2NV+eDebbff1BYwku/ne4oF
 WeD7yh7nBfirx4tcPIP5gtI6aktRBMjk+q01Tduj6VYoMOyPa5qWMfa7JppAWdcz5/qeH13pcIt
 gXeDpRYSMwIR0UygyfVmyzSKgiW9YZANmU3NHFqZgJWxMVUoRWUPVTUxmIW524HB4QSWTMB52LK
 4oXGOtD58qojUvROPqEzaRYyObN8+ZH6kWEPqoUaSjTSJSq
X-Received: by 2002:a05:6512:234c:b0:5b6:95e:87ee with SMTP id
 2adb3069b0e04-5bcde6bccd7mr4155248e87.13.1791881893829; 
 Tue, 13 Oct 2026 01:58:13 -0700 (PDT)
X-Received: by 2002:a05:6512:234c:b0:5b6:95e:87ee with SMTP id
 2adb3069b0e04-5bcde6bccd7mr4155231e87.13.1791881893424; Tue, 13 Oct 2026
 01:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20261009072535.3039944-1-david.marchand@redhat.com>
In-Reply-To: <20261009072535.3039944-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 13 Oct 2026 10:58:01 +0200
X-Gm-Features: AclHuK_gWGSKsNcoSap1BftMHzaja7sNzkWC5JxdVnPpK2rPndrJdfYFDiXZBY4
Message-ID: <CAJFAV8yY3zH0pXNiOim+ec9N+uDNZ0bQ7B0CtzkrtZV73569RQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: remove driver alias macro
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, g.singh@nxp.com, 
 Nicolas Chautru <nicolas.chautru@intel.com>, Rosen Xu <rosen.xu@altera.com>, 
 Tomasz Duszynski <tduszynski@marvell.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>, 
 Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, 
 "Min Hu (Connor)" <humin29@huawei.com>, Liron Himi <lironh@marvell.com>, 
 Martin Spinler <spinler@cesnet.cz>, Tetsuya Mukawa <mtetsuyah@gmail.com>, 
 Harman Kalra <hkalra@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Matan Azrad <matan@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Je2ZBQ3CxQBhlvBDcGBHK_t0Z74i3L-AzI_4CWQJRGU_1791881894
X-Mimecast-Originator: redhat.com
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

On Fri, 9 Oct 2026 at 09:26, David Marchand <david.marchand@redhat.com> wrote:
>
> Remove the RTE_PMD_REGISTER_ALIAS macro defined in the vdev bus.
>
> The old macro relied on a trick where a static pointer was first
> declared as NULL, then redefined with the actual alias string by
> the ALIAS macro.
> This required careful ordering of macros and was confusing.
>
> Additionally, the stringification of the alias parameter meant that
> aliases containing commas were impossible, as the preprocessor would
> interpret them as macro argument separators.
>
> Replace this macro with directly setting .driver.alias in the driver
> struct definitions.
>
> This macro had clones in the platform bus and the ifpga bus, though none
> of them were in use, remove them.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied.


-- 
David Marchand

