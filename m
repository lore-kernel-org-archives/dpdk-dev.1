Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FD0FA0C26
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 05:21:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B3E4042F;
	Wed, 15 Apr 2026 07:21:16 +0200 (CEST)
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com
 [74.125.82.196]) by mails.dpdk.org (Postfix) with ESMTP id 4240E402B0
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:21:15 +0200 (CEST)
Received: by mail-dy1-f196.google.com with SMTP id
 5a478bee46e88-2d52c7f92b1so5686349eec.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 22:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776230474; x=1776835274; darn=dpdk.org;
 h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
 :cc:to:reply-to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibJcwMgWu1G4nqMTpbdygReHEysJW5cqyWmIs/K2bTs=;
 b=Uu8RSPAv08mp4IasyOuv7VANr5ILpkCByX7n23YeBOlmNk7dYvFFGjK3rxf7o+OkYA
 kwTc38igfDb0/CzFei3qaD+uO8AbxI2Ce2qSqGjky2Nx2PBR0Fck1Cjl5yQ7sBbU28Jm
 mKLP32qHAg3OkxK86RGxPH7y0eQZc7tWB21QHkTqM5YrbYWsUEGutJQl0av0XDO6JsnR
 GiiUXdLTXd86dfx7HpVuYjNwu0RQw6DQJ0cB0rIapUPShYue7NvHWyF5GGe/foS9uaA2
 JTNDYnlZWbMdz3UCuM6Vn0R/MoDVC4LagUrWsfMqpjB7MJRqEWzVa419Bi3urY12KcqK
 l7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776230474; x=1776835274;
 h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
 :cc:to:reply-to:from:subject:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ibJcwMgWu1G4nqMTpbdygReHEysJW5cqyWmIs/K2bTs=;
 b=CgpAZcKgVruJbv8DsLsOObaOmkffsTsgV7mPFbp+hORxEl5k9zhJVPuv8MIc0WLk6m
 IZvydOvXHyILnB7Jhcy+cax0Ne91cIG2VTe1nC5M5BojRbdABEoNkXSe4zXP2nKFISsR
 z41PB/Z+2Uosq+o4iXmOhgS0T5HPQS/LucyfL030nehOpzCq7Zx4gFNBUTFaOYj3Mb0U
 IdAaESj6q7OceEYJUqec8TMI5zjN5fTZBBNGzJYYCN80cWhYJOUmdRPbmshlV0gBPlkH
 fl2ryztl42kp0rJLcnuh4mEhPqwiVol5bYy+sRljcIc2Qphp95Yf6JTOo+u3MXPQ5rcS
 SRZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9bTAq6I/E45VSTHEDGOsU58ugF0/eKrawxBQRKanpTFP0xhQiRy9fv5p5hb30tQv+ZTQ=@dpdk.org
X-Gm-Message-State: AOJu0YyQjvZ8xsS6y3plQcRf41eNgmWdU7ID8NbhXQrS+1Xjxl9Fujxl
 GiG5bL3dNBN3BkNsQvQIxCqVib9xJpJuv2T/aOWn7P460N18kcE2AUP+
X-Gm-Gg: AeBDiev2/UzHtA8k2OhwJhRA4lja2HxklSrUUHnF09Lgxf3VO4SFLyTFqZPHLNqcDf1
 EujFDMs90zbtHZlrE6789Imq3O4RIo8ORK/y5XzKuczYkC/5G8xstcpoxZt0iWVubbxCsiWPtR5
 KNkHcXTsHJ2yfY9jGfuqomIkQffu3XS9oahJNv+mfeybOqGtnLS8zDQKdH3fsQ+AV7qtiaegR7X
 UEWo0LMCiZja/C99e7NdIH6i/uBoZTqHn+0YS30aB6Zty5QeU3+MQQz8jyykh+pFJZFRe3AbUEQ
 hUGoCqIgjgaMAAyFJOpe6pHtMuTbkrxZO1+7BvUD/rmCsPcawfWgCvNCwcTPQtms+k0E2hZbS0N
 z9JQuR9/3PD+0/NogNJA6DPJD3yLF8Gd2uS04hbS6HuVyxha+l0GL/FfAfDtQpCefbJ+dXBEHmj
 96jCuaGttq8v0EDMoRwveBIqtOY7M2yBRvWcKv4Iczcdc4uT2LBWV+0d8LpAgT5Qc=
X-Received: by 2002:a05:7300:e2cc:b0:2c1:7793:7bbb with SMTP id
 5a478bee46e88-2d5898a59fdmr11496616eec.27.1776230474091; 
 Tue, 14 Apr 2026 22:21:14 -0700 (PDT)
Received: from [10.177.177.78] (c-24-5-101-44.hsd1.ca.comcast.net.
 [24.5.101.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f65f9bcsm1352580eec.22.2026.04.14.22.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 22:21:13 -0700 (PDT)
Message-ID: <29bb358f0685299cb0cb80a43f75c827f8218236.camel@gmail.com>
Subject: Re: [PATCH v5 v5 2/3] app: add topology aware test case
From: Sudheendra Sampath <giveback4fun@gmail.com>
To: vipin.varghese@amd.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, konstantin.ananyev@huawei.com,
 mb@smartsharesystems.com, sivaprasad.tummala@amd.com, viktorin@cesnet.cz, 
 wathsala.vithanage@arm.com
Date: Tue, 14 Apr 2026 22:21:12 -0700
In-Reply-To: <20260414193850.1696-3-vipin.varghese@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
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
Reply-To: giveback4fun@gmail.com
Errors-To: dev-bounces@dpdk.org

Hi Vipin,

This is my first ever patch review with DPDK.  Apologies if I am not
following the right procedure.  I welcome any feedback or help in
correcting the procedure.

However, I had the following review related to the above patch.

I see that changes to app/test/test_ring_perf.c introduced the
following functions:

get_same_numa_domains(struct lcore_pair *lcp)
get_same_l4_domains(struct lcore_pair *lcp)
get_same_l3_domains(struct lcore_pair *lcp)
get_same_l2_domains(struct lcore_pair *lcp)
get_same_l1_domains(struct lcore_pair *lcp)
get_two_numa_domains(struct lcore_pair *lcp)
get_two_l4_domains(struct lcore_pair *lcp)
get_two_l3_domains(struct lcore_pair *lcp)
get_two_l2_domains(struct lcore_pair *lcp)
get_two_l1_domains(struct lcore_pair *lcp)

In the implementation of these, most of the code is pretty much
identical, except for the topology domain type.

Curious to know if it is better to implement a 'common function' -
get_topo_domains(struct lcore_pair *, topology_domain) - as arguments
and call get_topo_domains() from all of the above functions. =C2=A0

For example:=C2=A0
get_same_numa_domains() calls get_topo_domains(lp,
RTE_TOPO_DOMAIN_NUMA)

This will make it more cleaner and will help changes isolated to one
place if there are 'common' issues.

Appreciate if you can let me know if my thinking aligns with the
correct implementation.

Thanks and best regards,

Sudheendra G Sampath
