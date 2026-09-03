Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C33C624DA
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 18:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A4134026C;
	Thu,  3 Sep 2026 20:58:59 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7763740144
 for <dev@dpdk.org>; Thu,  3 Sep 2026 20:58:57 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-85590c5aeabso110700b3a.3
 for <dev@dpdk.org>; Thu, 03 Sep 2026 11:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788461936;
 x=1789066736; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a4d+LmKv5BXPx2uOMz30A+dqZMqz2Kiz87kaEThhXXI=;
 b=j7nVzM/d79iBhOy+xOj/dRro6B6fWnvCUe61YMBH7eD+IT6PmYSflaeve4DI0dfBVd
 6oTEt5lkY7d8tM7aanPTQpPd7AARjGT06zR88LGqJXdBYyWodD5DE9etXHZ/uLI5OlLJ
 d2JaVRI79rpa0IpdpvSEdidr2zRn2xLqXY9zBVfMoDcMaO7O3td0hglaEOL6rh6WGZki
 PFIAqcfRTTO9rkj5LqLstqdmYjpDO1E3JNh63SdV/pdiU8hPPiiJtsNnoIPj8+NxD2n2
 IbK36xsCie4pGWUwvRAXR+fRvAKDtpCCw3F7oeubEAl9nuYqwqTF6vmBmYC5rCnzR5Nz
 Rhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461936; x=1789066736;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a4d+LmKv5BXPx2uOMz30A+dqZMqz2Kiz87kaEThhXXI=;
 b=MR4vp4RV6gq1LupfLkLzhj2qgCLkzZ0SUFtgJuI1HJky0tceWjcSjahLQPkrCfYdmO
 SHo+NxjBMQmnEy5y5/6VXq/obZNPnR461lqTho1yCgRIcBO00xfapQLXKGr70IOU6IQm
 dKFCSuPwKLj8VgP+rfk7FGTIBcp2Mzg5tOUk0JMW6Z7GVofs37++Q6xY747bdVucmy35
 MnCCW1KUVnNNLwBH0OFz9CeV+DxiQkfnt/ImYO1Ng2C3JS1rUgm4b8GYI4nfkhCamUym
 5hF2geCeHUGqfjaLUlO6eJruhr9GTkmd3R/wno7oJpC6gnuAk0lle/t8Zyut6fe/V2Nx
 +6dw==
X-Gm-Message-State: AFuF++nes6DgJiQ0eAnJal1O7++UkIOL9iSDxSsb2tWkpEe4oTzFHhYP
 Um1ST4Ab/baV+NJthnlpECfiJw8DuWXeEeVRPKE8T5VZmZZFr9MysZbL+2oMMZa0En9306q4fq7
 KC2NY
X-Gm-Gg: AYBFou0R4Nc6qY+ucymSfDdd3PsZR+/8YHQYob8XbIP2lAdwq9sXlW3nkFO20F4O46i
 ShAmJX/gvoowbPfpjZe0Qs/Jw2ksTrQDTR1tgu6H2BDrCAnbF4f1z0sYMr/uW6HhfNFSIo5Uwo/
 p9tTN2YrnC/9/Vp2kCRq1yEBDWzb54R0jyL1SY9Sy/Vo5Aqhccf80rwjkzpOYMakCh39hm9NFDM
 X6V3c/Bt1ppwXckfjpQlL8i5ckdlyQ6Vzvbn8kLrrcQEXUdRqJwZscrlqUK/YDlmhVm9KYGjRMb
 7bp/n2RqMyVCqvOnzaL1ZtKkkitP84mP0dlBohYfvmbrnS3rqe7hUWVxG8QtPcK1uxiUCElVRv9
 LUDsmEy5l3cTTbPk6S/jRfzex9t5jyJ/pFL8jACyoQT5WWspN3sr5AyK4aO1QkvTEE9MqUkdmj0
 +WRaOczowxuyAprq8xur2qphOI0M5+1+TMQF7s5LJ7ESLofA3RCOWChUlf/9MGCkx+W5r8PQdhX
 rWkbGzNOMNzXMDV7C0KJqlvgPyP5Q==
X-Received: by 2002:a05:6a00:8016:b0:857:74ae:ad76 with SMTP id
 d2e1a72fcca58-8616b46b125mr1368697b3a.26.1788461936239; 
 Thu, 03 Sep 2026 11:58:56 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8614f873cabsm307744b3a.2.2026.09.03.11.58.54
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:58:55 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:58:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v2 0/4] fix clang 23 unused but set warnings
Message-ID: <20260903115826.15b675e5@phoenix.local>
In-Reply-To: <20260829154706.52169-1-stephen@networkplumber.org>
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260829154706.52169-1-stephen@networkplumber.org>
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

On Sat, 29 Aug 2026 08:44:44 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Clang 23 adds -Wunused-but-set-global, which reports file scope
> variables that are assigned but never read. It is enabled by -Wall and
> does not appear with gcc or with clang 20 through 22.
> 
> Three of these are dead variables and are simply removed. The fourth,
> 'alive' in dpaa_of.c, is a real debug aid: it is only read by
> DPAAX_HWWARN, which discards its condition when RTE_LIBRTE_DPAAX_DEBUG
> is not defined. That one is fixed by making the empty expansion consume
> its argument, which keeps the condition compiled in both builds and
> covers every other DPAAX_HWWARN user as well.
> 
> v2 - remove more unused code as suggested.
> 
> Stephen Hemminger (4):
>   common/dpaax: fix unused variable warning in non-debug build
>   bus/dpaa: remove unused qman_clk variable
>   common/zsda: remove unused device counter
>   net/qede: remove unused app version variable
> 
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  4 ----
>  drivers/common/dpaax/dpaax_logs.h         |  3 ++-
>  drivers/common/zsda/zsda_device.c         |  5 -----
>  drivers/net/qede/qede_debug.c             | 20 --------------------
>  4 files changed, 2 insertions(+), 30 deletions(-)
> 

Applied to next-net; so that clang 23 build tests can run across all drivers
