Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BABCA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 14:31:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85A0840272;
	Mon, 12 Oct 2026 16:31:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 33AB84026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 16:31:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791815466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNDvJ0NFKKNJb3pZGCZRdMpHUD4j3kBRRSvcrJD5cbg=;
 b=TnvzrAd+Vv5rIeXWDvHFZGICKWL0ecwq7VKbWNUs9kDGxm+HYWCSyK9e6jWxpgNHGSsYWc
 tfTExBpodiICIQmuFwdA8lwX6Wm9PzH/UwVzAjjb0oDj2osa2+iqE9atotpjE9xVJXSyA3
 +BkV2MkHT6sIFXR5/lOxYOehpGDkz4I=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-zTPz1XYoNA-AKsKBxsXjSA-1; Mon, 12 Oct 2026 14:31:04 +0000
X-MC-Unique: zTPz1XYoNA-AKsKBxsXjSA-1
X-Mimecast-MFC-AGG-ID: zTPz1XYoNA-AKsKBxsXjSA_1791815463
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5ba402bfbc5so1147627e87.0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 07:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791815463; x=1792420263;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZNDvJ0NFKKNJb3pZGCZRdMpHUD4j3kBRRSvcrJD5cbg=;
 b=L4QREy0vW/77AYFSm+JeHNNIGBmyfXWzFFO7KYTyUtFZDgQSw/ypt6dcnMwgETEZ5d
 5AZRXecrDHWrj1HUEC3KEDf7lmBJZZ3tbxQRIoSi8fLwOOIpKPvXi2FX/r4bIxkFh1vl
 E50HN8lFKNMCdS+YFcstZRj/KoBM2hDHxrpMTmWvBMrtkJfzGzrgGcCu7RwTgSenVO8m
 B10RVAB+UmmU3xhDo6bXYQStl9KnznqSyV9dMnudI6TiO55+Y1U+bO2lJE/E8Y/zaCSY
 eQR9jO02jAhtqYkKLLbWQ0yFbI2MupxJxCybcALzl7FKqz7icyD3L9TtldAzLi+iP8UJ
 7TCw==
X-Gm-Message-State: AFq9FYJkIz+OsTRiSZt/IpXDox8jpRgZ2NHySXN9fbMVPyqCYzt6w/YW
 Ff300N0TvocAauT9xDjscp/259DLAm79Hk40kapW6hS/b7cUnXQXkPBSrJNm6ZQyrw92E2LVgZ7
 BsiDykxJE0FKxbLs+O4Xslqy3Ri4jlEfPxEDF6Akd1X/rSQf65OchSwQxe6/n1cgTX+mRlYsa23
 tby7wYNNwKY3CehjYCk04=
X-Gm-Gg: AYBFou3E64mzWSq70kcdb2V51JktzCYIG6bR1BWccBIYXwRfwieSrNZoN41u/xQly5J
 8454xcPySU4twrSSGAUhJg6nPN3VT35aIK82zjK1yjmH5bBxfEFY4s0+v3Ncg2KK0JR6hbVg0ae
 7CTjhU6dp6E5MKUoDeJudahCcHalrIip5akL7GPIi32AaB1/OD5kwfxTHhF9Rrbd1mlfkzUapnp
 HeJXLrBN6wKhcY8g1sLLYaf74BAMgub2vpeOj7cTJqD4a5G
X-Received: by 2002:a05:6512:2315:b0:5ba:36c5:4c14 with SMTP id
 2adb3069b0e04-5bcde6b373fmr2942656e87.12.1791815463388; 
 Mon, 12 Oct 2026 07:31:03 -0700 (PDT)
X-Received: by 2002:a05:6512:2315:b0:5ba:36c5:4c14 with SMTP id
 2adb3069b0e04-5bcde6b373fmr2942639e87.12.1791815462962; Mon, 12 Oct 2026
 07:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20261012141037.1451851-1-thomas@monjalon.net>
In-Reply-To: <20261012141037.1451851-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 12 Oct 2026 16:30:51 +0200
X-Gm-Features: AclHuK8EbK2U-Q9_CVKqsaMnCRbuztVR-xpKArJGCLYCi-9if6dxBwM-Il1LROs
Message-ID: <CAJFAV8yrTbrEyHh7i-h-1BPdhR5rawFUW0t_6Uw8KNA1uuewtw@mail.gmail.com>
Subject: Re: [PATCH] eal: prefix lcore role values
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Huisong Li <lihuisong@huawei.com>, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UkytEpJZCN_X0wHDzYFRtGPge-8sOpDPuDZcbRO4f7c_1791815463
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

On Mon, 12 Oct 2026 at 16:11, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> From: Huisong Li <lihuisong@huawei.com>
>
> Add the RTE_LCORE_ prefix to the lcore role enum values in
> rte_lcore_role_t to follow DPDK naming conventions.
>
> - ROLE_RTE      -> RTE_LCORE_ROLE_RTE
> - ROLE_OFF      -> RTE_LCORE_ROLE_OFF
> - ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
> - ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL
>
> Old names are kept as macros aliasing to the new names to preserve
> backward compatibility.
>
> Suggested-by: Thomas Monjalon <thomas@monjalon.net>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
> This patch has been reverted in June because our CI was not ready.
> Applying it in 26.11 will be easier because there is no ABI check.

Yes, lgtm for this release.


--=20
David Marchand

