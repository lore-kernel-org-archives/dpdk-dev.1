Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A852FC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:18:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8161D427B2;
	Thu, 17 Sep 2026 18:18:34 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 6051D42796
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:18:33 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cebcb8d7so287495a12.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789661912;
 x=1790266712; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LOGZdIvw3mGTuem6EyF+fqYUd2tCdkOQFd0AZ+3afOc=;
 b=iT0pwmrf2G/ClX1EMeMYXhqWVEH0gXTjxLL3YLyT/uyGTbG9QQxrW6VztmR9bCDmja
 0wBQUzpv2Lf/cSCLRUgzoFmlvkbar6Cgfm4Nt1X55Garjq2lHG0GHpD8RnLxV3EAKWIw
 47i4DfuBWpzoR21+0nRsjRlnga0l6d2VJvJFgauU6Z4vxEGpg3Pm+kJA/69A7YTp4JTg
 rNLBpWo6rZdc5+ZUlFfprzdr8MRn+lpVJLJ2T1cxoo6zpbsWu0GjmI9ODjupWofi8q6q
 gALyPD4t8hBiveoJ76JOpkL3GbOMwp5F57Qf6kw+UDAxE19lasjLGg2qwhX5YE8sHuqw
 ou6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661912; x=1790266712;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LOGZdIvw3mGTuem6EyF+fqYUd2tCdkOQFd0AZ+3afOc=;
 b=EBw+UhaEym/mqGPeTgfH15OffyBndAjlVuhdgGaiuREfFw/7rzavc6v0G9tXNIXKQZ
 FcYxaOqcVFKF+F8Qq3n6/McNr5tV8CzbxQiNCvBDcUs3gNMCIspa52w7XJXrZs3U4vnA
 mnjhNsGmfLNtorPGZjuTGr5OGYmA0wQHZ+Ory7KH8MkwfKWeeeJ38mtwGlN9/+2dVUII
 0YQF4ZaWzURNKl2NFrQgJEBs9KeM8lYFNCNLOdBr3VeiEC8eC23GZXNPPET8l80R9E8T
 KzkIaG0z9UN3H2x6KAdcDwCamz+5CaflucLQ4cZG1kQlCsLg2NL9xVxMEt21HE6MOnY/
 Pw7w==
X-Gm-Message-State: AFuF++lD+xRMwcqFY03zuoEZSjWetZwvkQ6F+XunuJya5GAd5DHOO43P
 RT38FANiPXKtz4CYRPjGRj8wbKRxuoQ3SKAl9FlpwMLwYWwgfJIjpujFpTDjxpEeI7YeJEPiZyA
 jR6dh
X-Gm-Gg: AYBFou35wgauv5xPQ9h7E1uMJ/RqeyqtOOzYmoYjZMOyhWITa2VvhwXQWHDeYAobh9o
 JkXs/dOyGeZ8G6I602cGounZeN5i7cj1wD8z3pOu6iUuD6DGlw27Lw7jGLuEcbMNHEa79U9Uqww
 vSEzLev+ttNIXj0igscVyPkL9qJY/MnuGuAehnxNk6tleux/I9y/TWlAOBKChRf6L/Qfu3ZK/1Z
 /pOGKvFq9ZgpFrMWIE1cYw1AlxvPMuCaMLy7a6At3IFemFIHFWpFb8aryvkSMc8uRDPSnnoInio
 ucsuFJmocaS6xd3amoSvssdmJiq81JT5PgSWpPdI/nYEWfG7SJFrfV87AOoTiVrmuGm1g0/8fd4
 CxUwUIy2wY1dmiSsTJtJ9K6cwBRWdbgUkoFjL0v6DqMxIiLryJiI9I9FrYXb6dFHLYWysbBNarM
 KzVvEjtpO2QR9hrt8cNbP9WJUMDwnkh9BQNOf4PoNdiMLNMeVM0XjIu8nnP9FbZtGkpcXIbKYwF
 IYUUMGfiLlHfSxaOD0Gj38So3aJ1WgtX4QH9YPMBxgnztb4afA=
X-Received: by 2002:a17:90b:3dd0:b0:39e:28db:b950 with SMTP id
 98e67ed59e1d1-39e361aa313mr5449221a91.16.1789661912218; 
 Thu, 17 Sep 2026 09:18:32 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3c06423esm4824952a91.15.2026.09.17.09.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:18:31 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:16:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>
Subject: Re: [PATCH 09/14] common/cnxk: update bpid config for cn20k
Message-ID: <20260917091632.0aa08979@phoenix.local>
In-Reply-To: <20260917071016.2366467-9-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
 <20260917071016.2366467-9-rbhansali@marvell.com>
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

On Thu, 17 Sep 2026 12:40:11 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> For cn20k, Rx chan bpid config range increased to 10 bit from 8
> bits. These extra bits are reserved in cn10k platform so separate
> platform specific bpid range mask is not required.
> 
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> ---
Patch 9/14 common/cnxk: update bpid config for cn20k
----------------------------------------------------
Warning: the commit log says the range grows from 8 to 10 bits. The
masks go from 0x1FF (9 bits) to 0x7FF (11 bits), i.e. bpid (9) plus
bpid_ext (2). Fix the log.
