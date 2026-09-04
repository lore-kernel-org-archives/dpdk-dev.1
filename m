Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA8BC624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 07:20:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 143FA427E6;
	Fri,  4 Sep 2026 09:20:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D10444279D
 for <dev@dpdk.org>; Fri,  4 Sep 2026 09:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788506451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NP6PJ9VUTF6CZuhdKT7kTnVe/B+B03OdWefz2uT140=;
 b=HgVcGbekv/ji5OTvv7pMy+ZsMAjLV2PTpM2/wZGqhhvJ/s7qztLAlaEHi/Cd/pMhu51hxU
 a38EAdVZ08TCg8ah9ShhSXNhr7n6q+QXw+iGMUj7fqlTKd8Hahvf03bskYENrqCAvi36A2
 QbZ65OcXBIAL1B7FVnrk0mPcurJqnIA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-kAndQgmaMCaTsHYDPdvPOw-1; Fri, 04 Sep 2026 03:20:49 -0400
X-MC-Unique: kAndQgmaMCaTsHYDPdvPOw-1
X-Mimecast-MFC-AGG-ID: kAndQgmaMCaTsHYDPdvPOw_1788506448
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b619951eaeso315827e87.0
 for <dev@dpdk.org>; Fri, 04 Sep 2026 00:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506448; x=1789111248;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2NP6PJ9VUTF6CZuhdKT7kTnVe/B+B03OdWefz2uT140=;
 b=XnyKhShMc3R+Copcq57+Pn2TJPfrV+hMskz3q1AaIs8OfZVR8sVmCSqpaiuhfu8lhy
 K1kQpBkzTSwdNr8cv7pUpWrV4Qi//L+Ex3rnM8YU/kMOdvbwOem1NY8Ppyg5II8j3lc1
 XG8pMKdI0hlmjXbiGbmb/kbNGTTwYewNdsPGdTG7ZIvr2BbJaw0GwjhtjRl3XWdcHSpf
 lHzVUr2VFeWt7UYsrk2d1U35k4jlKjwagUIckD0wqlohBCoQ5AH3zYFooGhanVpcEJ0B
 DWWwz56q6s1w9XhIT25qmP8Zq4SraMkkcp+1hA8wMoqtLikLJ7g19bKOhQqEZFRoMudj
 sD1Q==
X-Gm-Message-State: AFuF++kJm33Of8BvC6G3o3IY+9/l0bgGjfBlWarXRgMiCmCK1oHw2s9A
 K4Kc3rY1gOqlyDn3KiV7UrJsckZhMIzGzm7a+IFe3vA+IqB6MDcwjuZ1FV7NBv+TWKq3TDOW+13
 ++778MG+fbQdq3D2GD6I+d/sEZlPIH8q23+56QXAIMPVKI+VSPnnuAPdD36dOYjm+Ye4OVqkQBw
 w9L0I7CsgodetdoWBJTxY=
X-Gm-Gg: AYBFou0D8xuMbUoSaPRNlK6Jb0PmNLqk9e+nbn06V0rb7fNO5kQlDy17N+3zkZe+zQW
 znkRF6370liAzGypTTftS2VKan78C4lk2QfaQ4MMo3njuLgVcQWgFx2XqabYotRR7zTgIpZyLp9
 ZxWgNBv2aILaLHWD5NGuyy2eIsTLNB32DW4ScIjdf7jVnhzuKrylKTj6djufrfx/vOw0im1TYJw
 kDhIHKwWK18Ya3C9hzElMVA74e61cfcIE6O9Hi6ngRmiYck
X-Received: by 2002:ac2:4e10:0:b0:5b6:10bc:dc50 with SMTP id
 2adb3069b0e04-5b610bcde0dmr1363353e87.39.1788506448134; 
 Fri, 04 Sep 2026 00:20:48 -0700 (PDT)
X-Received: by 2002:ac2:4e10:0:b0:5b6:10bc:dc50 with SMTP id
 2adb3069b0e04-5b610bcde0dmr1363338e87.39.1788506447601; Fri, 04 Sep 2026
 00:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260903191602.924372-1-stephen@networkplumber.org>
 <20260903191602.924372-2-stephen@networkplumber.org>
In-Reply-To: <20260903191602.924372-2-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 4 Sep 2026 09:20:35 +0200
X-Gm-Features: AcwNN1UJIZmOFRyOl6nUKf2Jom68uX1B8rv7UJmxaiCBZOg8xXtJbYoH9mHf2Xg
Message-ID: <CAJFAV8ygm3sHS0jdBLR7mqPCYUeDo6eeT4Wr05hK0F+D-bdE2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] examples/vhost: remove unused but set globals
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Huawei Xie <huawei.xhw@alibaba-inc.com>,
 Changchun Ouyang <changchun.ouyang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z0YJ0TwCAYO1Uz9g_w_mp1aywj-brv-yCQHPvVzzlt0_1788506448
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

On Thu, 3 Sept 2026 at 21:16, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The vhost example tracks number of queues but never uses the
> variables. Remove num_queues and the num_vmdq_queues intermediate
> that only fed it.
>
> clang 23 reports:
> vhost/main.c:86:17: error: variable 'num_queues' set but not used
>          [-Werror,-Wunused-but-set-global]
>
> Fixes: d19533e86f1d ("examples/vhost: copy old vhost example")

$ git grep num_queues 84b02d16c53981e9163a3f1600651a533770553a^ --
examples/vhost/main.c
84b02d16c53981e9163a3f1600651a533770553a^:examples/vhost/main.c:static
uint32_t num_queues = 0;
84b02d16c53981e9163a3f1600651a533770553a^:examples/vhost/main.c:
 num_queues = dev_info.max_rx_queues;
84b02d16c53981e9163a3f1600651a533770553a^:examples/vhost/main.c:
 rx_rings = (uint16_t)num_queues,
84b02d16c53981e9163a3f1600651a533770553a^:examples/vhost/main.c:
         = dev->device_fh * (num_queues / num_devices);

$ git grep num_queues 84b02d16c53981e9163a3f1600651a533770553a --
examples/vhost/main.c
84b02d16c53981e9163a3f1600651a533770553a:examples/vhost/main.c:static
uint32_t num_queues = 0;
84b02d16c53981e9163a3f1600651a533770553a:examples/vhost/main.c:
num_queues = num_pf_queues + num_vmdq_queues;

The last usage of this variable was removed with:
Fixes: 84b02d16c539 ("examples/vhost: support new VMDQ API for i40e")

> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Otherwise, lgtm.


-- 
David Marchand

