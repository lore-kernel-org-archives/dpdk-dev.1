Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10038C83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 23:19:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F3DF4021E;
	Wed, 16 Jul 2025 01:19:55 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id B05484013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 01:19:54 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-236377f00a1so56902625ad.3
 for <dev@dpdk.org>; Tue, 15 Jul 2025 16:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752621594;
 x=1753226394; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqrnLfzzWYSNu2/rsQbsNPXxCXMYLiqMCXi9ICgo3OA=;
 b=amDC0r//Ern3J1BxLvBfs3qqA8h3yd3uUV+4OuL2q6n3OjnCQKVRON6sL0KvFWIeiN
 zdolO/y0RW5j744545pWvEMmJr6Xv+VaAz67qk4/8PignzjmmVrxC6nXWR83Qfx9FeE7
 vUn4RSMTf2n93837BUQaMouSxYeJb/OjG3KhD271Hc0hDIDCf/g32uxX8xe8HGh591nj
 pExDxXuHNMXnEbsJNl2ZRlOFwZ9gyEjqqKaz98uF8iTUqUTeLcIQ2qYQyhw/+YV/p6A4
 sc25Iu5vj6+g+TR/lTINtdiiDtW4Fc+NLgMnhmMWfKhmY9mLNjOiqAZCqRHpYmSLRryQ
 whMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752621594; x=1753226394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqrnLfzzWYSNu2/rsQbsNPXxCXMYLiqMCXi9ICgo3OA=;
 b=YeMVog0l0cXhowK9Hak1ekF8ZVeKYBhOI6QuzF0ie4rYub3ZVwhdUS9A5gjWlsZgCh
 FLUdhpYv7WWAzbDH2BVkBSibW1HNqsj7t5ufbkGzFBS83ZRHPvdTnVv0ysuH8yK/H/lR
 xe1Tk6LZerbdRl91yyFZKM51Wrv+3uAXor0TcvcBZWYTEpcD5szIzJaAcHBRmg+NcQTG
 YjU+kCfYjHgsCzOMuhBfhtBaUTrK1iQqYHN09Ij/qkZZhwSDy8DWBgCNO+5qKVyOX6ph
 d8Nvm3r+P0VzFwu19z4WbuXuqB0fpoO8ilcAwASHw4zAYo4q5ZP1HkarV6nhNYpPJqpq
 T4sw==
X-Gm-Message-State: AOJu0Yy5nhrgxxE2UdOh+oV4WbyfB5lxj4nyIKV3ieZi+BEyYLSHQh0Z
 x3HdJcCFUN8NUWR/uLdWZrTtkFZ5KRdlNUHh6q7q3Tb+0YlJTl8XHRC3qCsl/JP1cZYQOs9QUD/
 cLiJvfNU=
X-Gm-Gg: ASbGncuKdZNA6RW9OHbONGSGlivl0YuSQL+TVtClD0WgPP+OsZljuzbfF//KxZHIiYw
 II10/d6c0sBg8YFpM6YBVhVtFXgEo5iQ9YbDhfsqwHHJEC5X565kUfYq3nvvJ7ZQq7n4g84qPZw
 kwZXcrl0YTUEtpw+a0iEU90dXW0ljUgMUDA3mimtY8mXW2DTTBuuVhJVEKWK9MlRWxOogVRj3Mr
 enozuaDICzqwnCPh/CrrgDOIIn2zAYRlGt93fXmReWpWoPxr+u+fg8p+T1QSe+cczwpGJ3Wch7O
 LVQ3pH5MCd1duQ1MjDWg2rsfO9SEl2E5wArx3+RKyqqyvA/yZTdvjt6LjG0KjtWekbHEt7rsg3Z
 jTK/usbvSERih98mmJtVi/snqnuctV4+8IH3xuRHxWBipcB5hNsmppMDRt6GqF0qhCA99f2ZNsd
 k=
X-Google-Smtp-Source: AGHT+IFY6J6LnO1H7VJz1SmYkuTbXSGSfv7gZgZ1Eccp/HH2y88IUXTy7qwOP4lTsy6Ncdj7nZ+GDA==
X-Received: by 2002:a17:903:1b04:b0:234:a063:e2b5 with SMTP id
 d9443c01a7336-23e24f4aabemr10532515ad.30.1752621593603; 
 Tue, 15 Jul 2025 16:19:53 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de428b06bsm112819545ad.41.2025.07.15.16.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 16:19:53 -0700 (PDT)
Date: Tue, 15 Jul 2025 16:19:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, Jack Bond-Preston
 <jack.bond-preston@foss.arm.com>, Kai Ji <kai.ji@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Sunil Uttarwar
 <sunilprakashrao.uttarwar@amd.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Gaetan Rivet <grive@u256.net>, Dengdui Huang <huangdengdui@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Rosen Xu <rosen.xu@altera.com>, Matan Azrad
 <matan@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Devendra Singh
 Rawat <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>, Cristian
 Dumitrescu <cristian.dumitrescu@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, Chas
 Williams <chas3@att.com>, "Min Hu (Connor)" <humin29@huawei.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, David Hunt <david.hunt@intel.com>, Radu Nicolau
 <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>, Tomasz Kantecki
 <tomasz.kantecki@intel.com>, Sunil Kumar Kori <skori@marvell.com>, Pavan
 Nikhilesh <pbhagavatula@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, John McNamara
 <john.mcnamara@intel.com>, Erik Gabriel Carrillo
 <erik.g.carrillo@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>, Aman Singh <aman.deep.singh@intel.com>, Wisam
 Jaddo <wisamm@nvidia.com>
Subject: Re: [PATCH v3 2/2] doc: remove use of '-n 4' option in
 documentation examples
Message-ID: <20250715161950.2aa8c6d0@hermes.local>
In-Reply-To: <20250715215718.7388-3-stephen@networkplumber.org>
References: <20240718184326.21375-1-stephen@networkplumber.org>
 <20250715215718.7388-1-stephen@networkplumber.org>
 <20250715215718.7388-3-stephen@networkplumber.org>
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

On Tue, 15 Jul 2025 14:56:29 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Many places in the documentation are using -n 4 to set
> the number of memory channels. This is no longer required
> and is unneccessary in most cases.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
> ---

There still is wide variety of usage across examples an many likely
require user to think "where is that binary?". It should be standardized
in the documentation.

Also, checkpatch complained about the docker example, but it
was always that way.

