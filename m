Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5FDC79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 18:10:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62821402D8;
	Tue,  8 Sep 2026 20:10:38 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 1BB474028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 20:10:37 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747eefae4so4156975ad.0
 for <dev@dpdk.org>; Tue, 08 Sep 2026 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788891036;
 x=1789495836; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ug2VerF+Mos9cyDrEKLnj29kG89MlXjcoo8fLWVr7Cw=;
 b=zVVlrl+/M1Enf6TvZ/6vBNvEXdqkLBHE+KtlC6EUxfduKmWkMqVccZ8Y9IKSmCS5UA
 IdlOOGUNaBHmqf+7a8EzCjyRTvPd9E5WO3k4NXr31G0jKq92t6RLXtpCZ4vp3NZzTYbI
 ZCIBLtEcXqdMHJ5YBUeQroXzCLAIliiZq9JlFUREpBgpsv32hJjXDDwDUv1rsO2esKyT
 0RZ2sDN8u6/R4vjyJtfK4r6INIo5gLINwFC2vxvIHL+QjfCgvtxusEyLf2soJrYqgiTK
 1OZZ5qWj2I33stkYX2JilmtauPhq8drlEJoEdJa9TeuYceJjZhi+YTly1VZYVg1p8Sx9
 7cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891036; x=1789495836;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ug2VerF+Mos9cyDrEKLnj29kG89MlXjcoo8fLWVr7Cw=;
 b=QK2XPH/q0HLmCWfLF9yWBu36KCQ7/NuDP+ph7EFKOQu0/soU9pGwPaeNHerohRe5ee
 Py6BOlYhAstCu7E1nM9Uxq/5UyBW3ptP42TW045DLF/P6JNofcHTmsGpNZdrmgYjirdM
 nX3eqrdG1bXs7PlZ5Y0HS8/ykMw9z1rTmVJeTM2LDj1ickZ1Iskw8epoXX8fe+aUtVZ6
 ZKNRyXIdDfSAduMOSbRWdgwCaK+L4RyHKGLmY/FrTuLog1nYLdI/W0W1CCLotgC3tOYf
 QJ80c6uwudKLFOENT138rWXpTvhaMoOmjwl6O4uY6mf/8Zz1GHO28g0/dCl3IbNO4I8w
 hnSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3yAOTlbbLvbWeX+DIbPsbQjXqBfRlRyNXXah0PDqzxEohs8oFPc4VeGDudst0m2YxnGc=@dpdk.org
X-Gm-Message-State: AFuF++nn4vFu1n7ZTE00DRJE0t8v1i5hzsNBfxY/hhIQnJ8Z88/epdpZ
 kkZKtct08FySXBGeWbK6/Wm1Otlswu5q+oHHlIKiXS11kSMUHs+WwQ7WIQ750wAZBf4=
X-Gm-Gg: AYBFou1qbnm1gTIkizjV4kR6o9lUxB/S7TnS71586FjTe4IOtVWGQFpnp+sD/kaIhoQ
 fRGWaXoPRosyhog65eRFPfAtmNRn7kK1Ns3I5tSeCPZmjP2cLIMua/xoxn0uXoxOllMSID3HITe
 b6nBFDCeBqPHWrggUkYraPElRXZo0Lr2g3qOGRQOHk/hj9pyOWJl0ogG+fVtiORUFzghSgMPC+S
 OnzIECBJOGr19NMbbF8ODUAHjG0qL+vhAroDXuggsHAYanFkW3pI8T2VC6umH6osOEL+ofoBl2y
 BcuW0rUqMq6RZqUL+Pi8PeGTX0wuXGy5jwio+4pHMUf/5si/xhk8NbUyWJ5103WZPBR2h/SbxpI
 Qp6hhbG0VFJ0/G4YSU4AzQK1u0DMS5uA5bn22ROBX9PUNbkYZy376g5Xd+2A9LLk9xei8OCup4w
 cvTMLV+nC+tbxxNm+euTlcKeiSALgDg2lYQKUDs9HCJuKwoGNzHOmqSgDTNxswOFWXi8haR8XcZ
 srvdsC+c6vtFPOMS1868XJ9sJbq/A==
X-Received: by 2002:a17:90b:57ce:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-39b8bc951e5mr6692142a91.3.1788891036084; 
 Tue, 08 Sep 2026 11:10:36 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08cacba5sm35263229a91.12.2026.09.08.11.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:10:35 -0700 (PDT)
Date: Tue, 8 Sep 2026 11:10:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrei-Niculae Petre <p31andrei@gmail.com>
Cc: konstantin.ananyev@huawei.com, dev@dpdk.org, stable@dpdk.org,
 sean.morrissey@intel.com
Subject: Re: [PATCH v2] examples/l3fwd: fix compilation when DP debug on
Message-ID: <20260908111022.25fd9aac@phoenix.local>
In-Reply-To: <20260731133739.223235-1-p31andrei@gmail.com>
References: <20260414025137.91776-1-p31andrei@gmail.com>
 <20260731133739.223235-1-p31andrei@gmail.com>
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

On Fri, 31 Jul 2026 16:37:39 +0300
Andrei-Niculae Petre <p31andrei@gmail.com> wrote:

> Update l3fwd example app to fix compilation when building dpdk with
> RTE_LOG_DP_LEVEL=RTE_LOG_DEBUG in config/rte_config.h .
> Move l3fwd_acl.h include above all #ifdef L3FWDACL_DEBUG checks,
> as previously one ifdef would evaluate to false all the time (as
> header include was added too late).
> 
> Adapt maintainers line from previous examples/l3fwd-acl (removed in
> 6de0ea50e9b9) to examples/l3fwd/l3fwd_acl* after l3fwd-acl app
> unification into l3fwd. In 6de0ea50e9b9, a line with maintainer
> expertise was removed.
> 
> Own testing of the l3fwd example:
> 1. It now compiles with "#define RTE_LOG_DP_LEVEL RTE_LOG_DEBUG" in
>    config/rte_config.h. See Bugzilla ID 1318 comments for full error
>    seen before this patch.
> 2. I ran the l3fwd app with IPv4/IPv6 ACL rules to see the prints (when
>    RTE_LOG_DP_LEVEL RTE_LOG_DEBUG is set) in the application around ACL
>    work as expected. See extract below (I added \ to format to 72chars):
> 
> // dump_acl4_rule extract:
> Packet Src:192.168.1.100 Dst:192.168.1.101 Src port:2048,Dst port:1846 \
> hit ACL 1 - 192.168.1.100/24 0.0.0.0/0 0 : 65535 0 : 65535 0x0/0x0 \
> 0xffffffff-0x1ffffffe-0xf0000001
> 
> // dump_acl6_rule extract:
> Packet Src2001:db8:1::100
> Dst2001:db8:1::101
> Src port:32768,Dst port:21005 hit ACL 0 - \
> 2001:0db8:0001:0000:0000:0000:0000:0000/64 \
> 0000:0000:0000:0000:0000:0000:0000:0000/0 0 : 65535 0 : 65535 \
> 0x0/0x0 0xffffffff-0x1fffffff-0xf0000000
> 
> Bugzilla ID: 1318
> Fixes: 6de0ea50e9b9 ("examples/l3fwd: merge l3fwd-acl example")
> Cc: stable@dpdk.org
> Cc: sean.morrissey@intel.com
> 
> Signed-off-by: Andrei-Niculae Petre <p31andrei@gmail.com>
> ---

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e99a65d197..6b6446a998 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1756,6 +1756,8 @@ F: lib/acl/
>  F: doc/guides/prog_guide/packet_classif_access_ctrl.rst
>  F: app/test-acl/
>  F: app/test/test_acl.*
> +F: examples/l3fwd/l3fwd_acl*
> +F: doc/guides/sample_app_ug/l3_forward.rst

I don't think all of l3_forward should fall under the ACL maintainer bucket.
