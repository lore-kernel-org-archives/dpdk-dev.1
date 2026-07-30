Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6169C531D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:14:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6621040279;
	Thu, 30 Jul 2026 07:14:02 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id D1EED40272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 07:14:00 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3810c5d691bso1547703a91.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 22:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785388440;
 x=1785993240; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DrdX0dwhIAHJuoka/MHr9EzAOH0f7DQwQBGEMCh58Tk=;
 b=rb7xAm93tIuVZWpFZAkGsD88ESBraEbN3RBrK5BU4W4HVOOdwNu+j/oOO2ttPIPfYL
 kMcXblyZIYce+HdTZ3X3ERbF9166pxNglHKe79tM62SZXESpcViNddRY0jDlo8Dzi93z
 l+s7CuHgUXhFXmOyCwmePdK9OcddhCBJcLZ/lLtU6GgGoVNyYN/y0OZCodovbGI4MnkW
 j+2vzaTx+Urn3F8oOkcRvnrNc2tfVsnKuR22NOClYm54LWw1lQJ7l5XN/3PmsmIpHGWV
 1BLXrFwQ+u9fJ3bp+GZsy76qdKLuYEe51OzfKC60etEYBi2UvhonwimbWxGICHWDAPXg
 L45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785388440; x=1785993240;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DrdX0dwhIAHJuoka/MHr9EzAOH0f7DQwQBGEMCh58Tk=;
 b=g++qE3J4oJo7e76+PnFdgmt0Updop4RnqWq3H21zFgqI5UnlRaCk/blumlfqoirOKa
 T1cLUjlVrc6PjtUbU6jVXgtjPi1yr8/0q7xaIMtw7z0sENlISi9lybBvKF333jtaMgeA
 O99BkNQeI12YARyUnxIu9mtMopQ6NHrSMZIK/YdvK3w6RtgCyM8drYtPMh/XLNV/Jh9J
 TN54q6uO0myuMGFiv3RbVyafL2shEgWRIIfYkCIT8f2RO/YRJqMOcdST6AaPOk62Tnls
 hpY3xlauG2ODMb4UaMv2qCVLfXVfuy0nHsDNKC3UvEkwhGYbeGpQDU93tOZ6P3HSMo0x
 g89A==
X-Gm-Message-State: AOJu0YyZeup2rpqHUs8PmvMqeUsl8seDTpQwMUuEl8R9H0qwIsufbSAB
 xUHMlQ7tpLKgXkLzrZOpqMdVEm4rJJY9BrVL7S0tl1gczTRF25YtxGBvfLT5HXUs0eY=
X-Gm-Gg: AR+sD13l5y1WKjbQ9cVA0uoviyAl8Ihgo/HIvZZ5i/M39HTtJsUqGIeiQvrvRH3iibd
 cep+ehS2UmpaTcUpqeRGbS3BYmuTg5PitMxwzUmIYgvt/aKnMKvPZuFoocUH6gvsjfip7SPy/wZ
 EUoL5u7+guyHX9HcL9cZBIcyUU8Tx92Pc5n83WsMTKKPTBzXYIhmwQevxpfMQ2bKV1thRZv+zTN
 5MC33LrEAFJ+qc/6iK2yVPUbVp+YpKyDEfCTCf/vhIPeEoDTkPl17bAb9Ap5ZNadmsZILC5wQ47
 uJe5l2MEvumdvzbhAzZ8NhE8a8TpEEIJGEyOtEu4HGCWqt1zUfTpJ0mTyf5vsba4phkSixHyxNC
 Kco1lPW6+wshVPqxaU9idzAVKNUZOF7qjwtZvacxc1nJ1klP+LZsj24tegLQVfamEfrhZByat82
 Y1MWIP3Ki01MQEOcUd5vdJEl1ffqY8ig7lF7EIShIUii8vZHUwoIG7K2MniGDs5WxxcRI8xWG1u
 56YyjmNkFZOYkLO3y3Oya50i2U+TRl9XqvHP5hX3dEiLCPKmKaX
X-Received: by 2002:a17:90b:3c8f:b0:37f:9ce1:736b with SMTP id
 98e67ed59e1d1-38f9c03f2e8mr976507a91.33.1785388439822; 
 Wed, 29 Jul 2026 22:13:59 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b670dcsm15808245eec.7.2026.07.29.22.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 22:13:59 -0700 (PDT)
Date: Wed, 29 Jul 2026 22:13:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Sergio Gonzalez Monroy <sergio.gonzalez.monroy@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>, Pablo de
 Lara <pablo.de.lara.guarch@intel.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Ciara Power <ciara.power@intel.com>, Xiaoyun Li
 <xiaoyun.li@intel.com>, Thomas Monjalon <thomas@monjalon.net>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Sean Morrissey
 <sean.morrissey@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v2] doc: remove unreferenced KNI and examples figures
Message-ID: <20260729221352.71f2e449@phoenix.local>
In-Reply-To: <20260729094343.2330526-1-david.marchand@redhat.com>
References: <20260728114600.1870123-1-david.marchand@redhat.com>
 <20260729094343.2330526-1-david.marchand@redhat.com>
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

On Wed, 29 Jul 2026 11:43:43 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Those images were left behind after refactoring/removal of KNI
> and examples.
> 
> Fixes: 0d547ed03717 ("examples/ipsec-secgw: support configuration file")
> Fixes: aa0d7c2d3283 ("kni: remove KNI vhost support")
> Fixes: 59c51be41c2d ("examples/dpdk-qat: remove app")
> Fixes: 207361b35031 ("examples/exception_path: remove example")
> Fixes: 46971b273ec7 ("examples/quota-watermark: remove example")
> Fixes: ab6ebd70205f ("examples/load_balancer: remove example")
> Fixes: 079981e98090 ("examples/tep_term: remove this application")
> Fixes: 6de0ea50e9b9 ("examples/l3fwd: merge l3fwd-acl example")
> Fixes: 3aaa46977de3 ("examples/kni: remove deprecated example")
> Fixes: f78c100bc871 ("remove KNI")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Maybe a python script to check for unreferenced images?

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
