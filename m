Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DBCC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 16:13:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB33542D26;
	Tue, 22 Sep 2026 18:13:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CE3C04278B
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:13:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790093604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hY5Uk04OqZr7dPolCFv0nccSDbzwHQq/t48o6mN6Aj4=;
 b=TJh1pEwpu4lJejx2OeriQ+QO6eUzsOmn/5sPPmDSCoSbbVo3VyaZVPptQhlAgjOXOoQbaZ
 CmoB6kag4fABHyETP1VQ5UFYSH2G5hMfkI2eZImz4P7Msu0uTaaJidyNA/i67oeJ8uDKp4
 N0nB4ss4u2yjFkQpeWc84vetfrt0tPI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ceO51SSkOOSsxka3ZGkf4g-1; Tue, 22 Sep 2026 12:13:22 -0400
X-MC-Unique: ceO51SSkOOSsxka3ZGkf4g-1
X-Mimecast-MFC-AGG-ID: ceO51SSkOOSsxka3ZGkf4g_1790093601
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b5f2676aadso2739114e87.3
 for <dev@dpdk.org>; Tue, 22 Sep 2026 09:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790093601; x=1790698401;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hY5Uk04OqZr7dPolCFv0nccSDbzwHQq/t48o6mN6Aj4=;
 b=ZQld+X5i7mEgqWM1HU14ydHu0OK2rQTtqOctOtmuy06lCvb7CFKHHT8Yj59F0LoOry
 8VqM/a4BP/f2fE6tTqoRT0e7wHHKfYeZ1pd9Gi+NlsOFqozngKyujonh4qmQr9D82Zof
 MzIx9jkdH4XMKGEPPiZE2Y9wK/eaxIbbv3izNP9UJoA/Hkv0mIUeZTOc8q4xH9aCE/Pc
 jH4ctQVIL6A7xMEzaohK3j5dJhDTudraV66F4LJ9RmU/ZMAESR1j2aLFsBpOZWWgX35/
 2NBVmTrO9FpIaXQ0kpJ2AQujZj890F8WDdKkU639z/PzDBYQB8G/Z3ZEb1+LJoYnkKaf
 IpBg==
X-Gm-Message-State: AFuF++l1UnhZIWnNSs+eyq+aQeASWDGYIOHXSA4hMIpI0Qy+Wu62LufC
 Qu3Wowy3ihq6QTJS1XYiE5qKbtSVKNvQnjUNwGG3BlFOpK6CPpFt4AfdPSkwMoDr/EKuYh9De/t
 djzzWRV0G2y428LHR0dG+5ou4hah5yhQhPqnK8KPSjPzf96y1mqThX/yZJQ+iUXGvPggeMTlyw6
 lMc0wI6iBemXa/W/ZigXY=
X-Gm-Gg: AYBFou3AWVl1P2Y5Dj3ykjRdUmOOAgVpWomjL9rUGVtRJm1ElXuPUYb7fgrw7nc1WyK
 KT31aBmG1uhhFqrLJDCqqakUj8PjOHKN0R7AdO/TfcWAr3o4yvyAIPSHqyxs1nvIURXE6JEsmHY
 s8m1EaBKvfzMT9/tQz09ss/1lB55GfT6+RSe26Lm/Or2cccpheJDdXqSjOrYaZP+ZndE4s2no1u
 ULTLABsvtBo6ges9I4aMqrea+EOfcQm/TyC3qyedKqh7kVB
X-Received: by 2002:a05:6512:3c89:b0:5b8:bc5e:b584 with SMTP id
 2adb3069b0e04-5b8c195dba5mr4334354e87.60.1790093601187; 
 Tue, 22 Sep 2026 09:13:21 -0700 (PDT)
X-Received: by 2002:a05:6512:3c89:b0:5b8:bc5e:b584 with SMTP id
 2adb3069b0e04-5b8c195dba5mr4334342e87.60.1790093600753; Tue, 22 Sep 2026
 09:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 22 Sep 2026 18:13:08 +0200
X-Gm-Features: AcwNN1UjOkNSYl2dRPiRmW35hUxiOb35gmzPRy_NPQNe_y0FNpxWyUDlKx4oanI
Message-ID: <CAJFAV8wTO-xdChto3Tzs2ci1QThtLingNDE_i0bjREhiOORjsQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] drivers: replace strncpy with strlcpy
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -AlwNehSXzxt9simVmDQe92bi_TIE_b0lUGUj6cT_cg_1790093601
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

On Wed, 24 Jun 2026 at 12:37, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Many uses of strncpy in DPDK drivers can be directly replaced by
> a call to strlcpy instead, which is safer in that it always null-
> terminates the string. This AI assisted patchset makes those
> simple replacements, adjusting lengths as appropriate.
>
> After this set, there are still a number of drivers with strncpy calls
> in them, but those are not simple strncpy->strlcpy replacements, so
> left for later rework.
>
> v2:
> * fix incorrect commit ids for fixlines.
> * fix build errors due to missing rte_string_fns.h header include
>
> Bruce Richardson (17):
>   common/cnxk: replace strncpy with strlcpy
>   common/mlx5: replace strncpy with strlcpy
>   crypto/mvsam: replace strncpy with strlcpy
>   crypto/scheduler: replace strncpy with strlcpy
>   event/cnxk: replace strncpy with strlcpy
>   net/ark: replace strncpy with strlcpy
>   net/bnx2x: replace strncpy with strlcpy
>   net/cnxk: replace strncpy with strlcpy
>   net/dpaa: replace strncpy with strlcpy
>   net/ionic: replace strncpy with strlcpy
>   net/mlx4: replace strncpy with strlcpy
>   net/mlx5: replace strncpy with strlcpy
>   net/nfp: replace strncpy with strlcpy
>   net/qede: replace strncpy with strlcpy
>   net/softnic: replace strncpy with strlcpy
>   net/vhost: replace strncpy with strlcpy
>   net/virtio: replace strncpy with strlcpy
>
>  drivers/common/cnxk/roc_model.c                   | 8 ++++----
>  drivers/common/mlx5/linux/mlx5_common_os.c        | 2 +-
>  drivers/crypto/mvsam/rte_mrvl_pmd.c               | 2 +-
>  drivers/crypto/scheduler/scheduler_pmd.c          | 8 ++++----
>  drivers/event/cnxk/cnxk_eventdev_stats.c          | 2 +-
>  drivers/net/ark/ark_ethdev.c                      | 2 +-
>  drivers/net/bnx2x/bnx2x.c                         | 2 +-
>  drivers/net/bnx2x/bnx2x_vfpf.c                    | 2 +-
>  drivers/net/cnxk/cnxk_eswitch.c                   | 4 ++--
>  drivers/net/cnxk/cnxk_rep_msg.c                   | 2 +-
>  drivers/net/dpaa/dpaa_ethdev.c                    | 2 +-
>  drivers/net/ionic/ionic_main.c                    | 4 ++--
>  drivers/net/mlx4/mlx4_ethdev.c                    | 2 +-
>  drivers/net/mlx5/mlx5.c                           | 8 ++++----
>  drivers/net/mlx5/windows/mlx5_ethdev_os.c         | 2 +-
>  drivers/net/nfp/nfpcore/nfp_resource.c            | 2 +-
>  drivers/net/qede/qede_ethdev.c                    | 2 +-
>  drivers/net/softnic/conn.c                        | 6 ++++--
>  drivers/net/vhost/rte_eth_vhost.c                 | 2 +-
>  drivers/net/virtio/virtio_user/vhost_kernel_tap.c | 2 +-
>  20 files changed, 34 insertions(+), 32 deletions(-)

Series applied.

Thanks for the cleanup Bruce.

Even if the transition is not finished, it is probably worth updating
checkpatches.sh to avoid new strncpy additions now.


-- 
David Marchand

