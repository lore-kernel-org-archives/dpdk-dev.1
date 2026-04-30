Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F97FCD13D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 17:23:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A61D14021F;
	Thu, 30 Apr 2026 19:23:51 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 07DD6400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 19:23:50 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2ed0a45e970so1401230eec.1
 for <dev@dpdk.org>; Thu, 30 Apr 2026 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777569829;
 x=1778174629; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kP2SPviRTXqfHbCq38AxOOto1tM1+CoJXW05T8NsLu4=;
 b=sgqcz/+KzSReS9ErU7SSgMe8BjBxRaM1OUbkwpwCZRsJsTI4Csbg/Mkq5RfXKjdUYS
 gWgkXmnbWSx3hRIZPyaQbZsn2/YZpfkOG3+e80pCBuUfoNULvatlkZbF/LeK3OQjzHhB
 e4L/NRytBkNoIXm1pxv6+L+W3iEYFJRQGR7ZWElVnP8PXSEczl45d6xXSs8QAs2ILvUF
 3aGakt1vOfvabc5BlJhA/0dL8ona2FJ6r/UBO//OWfr/rpVHAPesSAirD+pdSfWhML/y
 B7YjJU76dp5ADTwdm1Pg/l8DOFXBuDdyrfEY0gZRdWgLtzO1/tLQWI82NOXycPtU7iDp
 8RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569829; x=1778174629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kP2SPviRTXqfHbCq38AxOOto1tM1+CoJXW05T8NsLu4=;
 b=IMCE9jdGgMM39u2sTZ3lf7W1TEiVWf7p00JWMsbmPmnnto2QwpOge0NY4CQ5E4tQJv
 FJUijcUOnUZcfqUn2LHGv5KDM+UWe6MTBX6bgy4uw+sb9RuXYLq4GrABhLRiJp0LG7FF
 bOPy6sMiNufjp0VTTVKyiEJXgk0WIjriDxSbku1VOuXUPx2PcOdKXA/JKTU8tPwHygyC
 LQv+6ieUupB5YfFmUjsGoalt0aAOe3AFJ0/0TgLu7BSss+WjzqunvdyVmFuFZInOSHS2
 r0lI9yM1JscMOsvFoH1su1RjvkEneKP0rv1gMrYULIcOYvzqFX/k7bbTEJUpMj7l6ajy
 pruQ==
X-Gm-Message-State: AOJu0YwvO0ytD7b1L/bIX2/JI9NpaSIikOwYUc6ZD2LBABiVMgVc0omU
 pmg/63AGydyxEDSaAzCkl97JDniQIEutu5Kotwjg1t3lpz/0rZExMcThACOJZZi7Pmc=
X-Gm-Gg: AeBDiesyhVRWD3/d3mYFmbineAWkJqwzvpMJe3TSFZX+CfdDmPpLi7dXGR+XVJCoZN3
 qWE/EZwTBqHp/F4ZhfP1zXy+uDQSSfiStd3zFJl6zwMEP+ykzSB6+VEjvEkU5vCtzqt7NBhNeRB
 B/K3U6TdyfFvpu/iY9MfOzhb4bfYgynG/2TiaP2t1rMwVgByiPX3RnmTCweyzytpJFY90HQjhzr
 a4mUlpW7kTITyYnrJMaUkYluSEPGGjNeZGJOG3ad9hm1y/ab6dGKmGuvXEMz4GNtgjA1/6KYjft
 xo4SCc1eys1PCyjQObRwDgj9OIw1gg3ODJXBW72KfvJhkn7YI8LAdVjqBTM98NAopowSzmikNie
 Mj/bdDylKc7JG8LRjwBvELH+NgbPsHzzlUf1X9dw6TEZVrpvgjMz5DKvDJjyrP70d9BXphZ8dxV
 ysNVwDOEg6d96EwrkRfk6aq9K5UoI3X9k/ddhyRG7bsDuD+g==
X-Received: by 2002:a05:7301:6784:b0:2ea:b85c:153d with SMTP id
 5a478bee46e88-2ed3e195b01mr1716116eec.27.1777569828845; 
 Thu, 30 Apr 2026 10:23:48 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3c05dc28sm647294eec.30.2026.04.30.10.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:48 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:23:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>, Aman Singh
 <aman.deep.singh@intel.com>
Subject: Re: [PATCH v1 1/1] app/testpmd: allow appending to flow dump file
Message-ID: <20260430102346.2c584694@phoenix.local>
In-Reply-To: <711f81af5087b82e7ebc27e6ef69e9c497ad8c63.1777541917.git.anatoly.burakov@intel.com>
References: <711f81af5087b82e7ebc27e6ef69e9c497ad8c63.1777541917.git.anatoly.burakov@intel.com>
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

On Thu, 30 Apr 2026 10:38:46 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> When dumping flows into a file, allow appending to file rather than erasing
> it and creating a new one.
> 
> Also, to disambiguate between "mode" in terms of appending, and "mode" in
> terms of one vs. all flows, rename `mode` variable.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Looks useful, applied to next-net
