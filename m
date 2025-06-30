Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642B9C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 18:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAE5A4067D;
	Mon, 30 Jun 2025 20:45:58 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id B43A9402B1
 for <dev@dpdk.org>; Mon, 30 Jun 2025 20:45:57 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7d467a1d9e4so3492385a.0
 for <dev@dpdk.org>; Mon, 30 Jun 2025 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751309157;
 x=1751913957; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OI1Y85omlmysNuQ/BAhHWT7NX9UEbMik6syGhwqVJEw=;
 b=xx+Nz2mbYdVlqfV7QPaFzCEnivln1xXGPpCeNh1NZ0v+Uf1iglFm9fq0T1RBDx6wCA
 jGdnp3oZ9o0kA+lnXHl0fAJ+Xvl5kqkv7F00S1B64LrR2iJ9MFFIYJKCWqgsBvMAAsf0
 2kzQWduO+Muq9yLP/i9A7cppqCAzw7DxjgCMZxwI5gsA1V60Na56A5hgAYSzCQQeM5VR
 zyDIQXmjPximzRVIw70hQdsAXHrkyn137G+V3ANSSwpMckkysRbIagrlAN0iJp0bmsc4
 j+RJDqn70+8fKOqUs2CxmbDT3I1epgV56zT+QN3OwNWx6cqREbCeedOT4CmaY3FP+x9x
 UUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751309157; x=1751913957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OI1Y85omlmysNuQ/BAhHWT7NX9UEbMik6syGhwqVJEw=;
 b=TGU6UtszDxuYdnExcRVrShUG73nRehuLNO+wZ/OW1ZPB+ImJ9seBqY+r4LvCccyUvS
 Ohdzsvtdko0eI9ZGX5JAANhjJKKb7qRTRian9kcI0Vp6sGY1UrqGi+styJS5h9gVL41z
 spnstQxaASaKC+WUNxSQY0My738W0IGa2Z4mE/PkB6E8tdSoDnpmJzGm4JjrpvWexc3Z
 2ewE5LikSRtkDK7Adt5Y0tcz9Ap2zHoK/FwrlBKZEpiYArPltVtONaT6Ic5aR2vTDcna
 ncnwNwC0+kMNQ/OTdXUoM8BIUoLHLNj5ZH8UB+omfbbWjj3TQBDKns9zaW952nkzxclc
 ++kw==
X-Gm-Message-State: AOJu0YyTSIVYBg7rZPFPbWRoU69QNNNkOTAI2SW3X36YIteCUVKCEFqu
 CCH26mJmh/l5qcvUUkC8rrRE+q7jWIHFa4qzWxQLyBrmTEXhhHFeDbhNGUuxn1xU6QQ=
X-Gm-Gg: ASbGncudI0lNtJxheVPSIr7cFPJTbcN04IaOTI9p4N30EtBzb/miLm2ukQp0omaFElp
 0wuL/4kPFfkTyFx4c3C2lyPIGMUibwyVCajrY59LEMctUXa+L8tkvVBu+l8JwTIctH18PzjTmeQ
 LdUiKDK3lIzandVSOo1TgP8XzMSX/zCnYMBwuX/KsObwJGwDqfdvqPFsBjx0YPX3o965jnwY7Tx
 zEW5j3t957ZNExHL6AoWFjt6/6WbjpcpHbdMKkIj+7E/LE8cnxMrww32t17CdDBtg1mrAJoEQaK
 DpvXfhoyT03iI1pP0+yoLwAESZV2mOX7qKrFLX96YXctQCg0d7dRF0qWOiEp8zhvlKrGTWbwtNI
 bt4DaEUcPWfZgURSIIAvt3cJCWKK+n/8h/9jY4rI=
X-Google-Smtp-Source: AGHT+IGlyZ3/Wk8Bse9SRm12eDjrOafS5j8F1b8sRpQ8WbO3w4XQqL/SCol5e3oJXBNQEoaOhF8KtA==
X-Received: by 2002:a05:620a:8396:b0:7d3:89c7:684d with SMTP id
 af79cd13be357-7d466e2444fmr90752585a.20.1751309157062; 
 Mon, 30 Jun 2025 11:45:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44323bba2sm642260885a.109.2025.06.30.11.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 11:45:56 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:45:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <jasvinder.singh@intel.com>,
 <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH 0/2] fix parse tunnel packet ptyoe
Message-ID: <20250630114553.181b7a1b@hermes.local>
In-Reply-To: <20250616082702.3422034-1-huangdengdui@huawei.com>
References: <20250616082702.3422034-1-huangdengdui@huawei.com>
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

On Mon, 16 Jun 2025 16:27:00 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> Dengdui Huang (2):
>   net: fix parse the tunnel length of tunnel with UDP
>   app/testpmd: fix obtain inner info of tunnel packet
> 
>  app/test-pmd/csumonly.c | 6 +++---
>  lib/net/rte_net.c       | 4 ++++
>  lib/net/rte_net.h       | 2 ++
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 

Applied to next-net
