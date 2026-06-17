Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34067CD98ED
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 21:17:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E09A40268;
	Wed, 17 Jun 2026 23:17:17 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id C26D84014F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 23:17:15 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-13986d61b4eso746519c88.0
 for <dev@dpdk.org>; Wed, 17 Jun 2026 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781731035;
 x=1782335835; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uy2HSu4iI/ZGALjEqv526I7CrhTQ7C4/m2AiVpeHFx8=;
 b=scucbu31vi9Q5vfnZDa4kEIm2/mE/POT/3vDAEpPsVLs1EiChoNxH5jEKaB9ACKziP
 0vbrQh7p57m6NkFAPKf+/Uug6stsxybwl25rmxkcG4JHXkgCkQAiq9zl2xViR8G0aIpg
 PF1/aQSLGOtCEf+WmCHlSqiZpUCSKTmikj8n+cr5pYSeY2KpqgL21gFQU5MRn5rqdTi+
 4rxDJedQNMpgkzmpX7iHSfL+4+se0K5LyRo75So4dOWNSOmESjUsNdtRUsgVRQb5wV+v
 cKeGc02eQmQbjg8lvMO1iZcFKoPGXAtKw28aU5ffRPrkR3eMgz8IpBU9WNco9FZ3dfGn
 ngNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781731035; x=1782335835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uy2HSu4iI/ZGALjEqv526I7CrhTQ7C4/m2AiVpeHFx8=;
 b=csN5LCRRv2xVMhjqcEcpfCa/GvV2EYKxhDYEOXRlioDqBNmfQisKHJkGsA6pHp8ITj
 em1QvAkmjUKXgz7Gr81PUlwIywJoxqDrQFXfKmONgqr7jJb5D6DjwINUkPSuTy/F7Ysp
 eBW40/og2dEfQvxoVXcIYDgS4rQrP4sF4uvGYxB85wQcQuqQ/UgZFoWLqlsSoN7Z4DPO
 9/sftjz0tfDcTCVo9FA4z/0033+HLfiNMPgJN1ubKdVsSLYilyoULX8rWauO++TmcZkm
 pRJBjSSAhv7xzX2MqNa/rTLynGoJ19Eabd9nKxV1VvrTkCweo3gB/FxLUF7HPR5MtW0J
 uDaA==
X-Gm-Message-State: AOJu0YwOKl/vvZZWJWvKl5lvhQOl9UsmqGQ03iLBIovdLpgD/uSDEyqG
 ljK9A2e4mQG0ppX2pqiDbfWkTeI8a1YfcB+Y2PP/TZCKwTVdrqjeNghw1ir9douuWgA=
X-Gm-Gg: Acq92OFBXCQfM8ekgiZRnlm43+/H2xmtaSl4fIi09Utk2aajdL9RANrS4f2Xstvgj80
 PM7n8dA718sqODnPPrNV3WaoiEIL/g7IS5LwkP5JRT1FNTqEvFsnyEaR7sSxIPmp3rh/g0Ov6Sn
 e3Y6NPd+rp+GnWb4RDFP+k8uzU1uEkRHmnv96NFIYLGl8LZ5IUVZf4KgqRzeGF26/Nx9YK6YB6M
 0E/kC2Ck3coZ8i7lD0cNmuxPNKDMU6piGc1FI49Rm81mWwSDQk628ts2ZyXh2OAoDjHn2yI0FGZ
 wQjpnArkwF0w87wzA+ZU/C/taF/F1ByC9kYLvvBOTq3N2TdnpNeacYZG5oKPzOTAsRPmi5tpeH4
 n3gp6mxz9GkQICj4HmUIUwgPcjdQ9LclgRoE5vS6GPJs1AjhLBUKQdIYkcyEGet218rshmox9Gt
 Tj0PCbASkJe128BP1aghjCQkD9pwalKmn+OXqcSWrlXKYLmKcS2KC45oiSGvw/KmqG
X-Received: by 2002:a05:7022:6198:b0:12d:de3e:86a8 with SMTP id
 a92af1059eb24-1398f6fa489mr2728871c88.38.1781731034702; 
 Wed, 17 Jun 2026 14:17:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b96d6c4sm17894774c88.9.2026.06.17.14.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 14:17:14 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:17:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 0/4] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Message-ID: <20260617141711.413b8b65@phoenix.local>
In-Reply-To: <e8f68b2da12a4bb58ccb580c49557510@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <e8f68b2da12a4bb58ccb580c49557510@huawei.com>
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

On Wed, 17 Jun 2026 17:37:39 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> I think this should CC participants of the previous discussion: 
> https://inbox.dpdk.org/dev/20260319114500.9757-1-cfontain@redhat.com/
> 
> (Humans may think they submit patches independently, but weights of their LLMs
> were already contaminated with the other effort. Hello brave new world.)

Didn't see previous thread. This effort was more targeted at
why can't capture which uses pcap_compile -> bpf_convert flow be JIT'd?

Had not looked back at other overlaps.

