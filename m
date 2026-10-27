Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08324606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ws64zXxJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BD5E400D5;
	Tue, 27 Oct 2026 03:00:46 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTPS id 839EA40041;
 Tue, 27 Oct 2026 03:00:43 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=vev6E5vnqqiLJc8M3chdFIDLpEKpXuA7f/ij/ycEMsc=;
 b=Ws64zXxJYzS9HEdaDKIzkXhS6cEQcjx+XNWSZRdEgZqO1r8feMQd2aGdfqDTmfaVipvJCeYh+
 pkp19RRRG+MBDdTygT+bjTQ2tbvQSMOiGThkuIfNZB+Lyx7C0WQCyJNpFA1P/LjfaZGc0MDZkaY
 bB2eL0zBtQyRw5jfrtfTzQE=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jDDGh4t3mzcbTP;
 Tue, 27 Oct 2026 10:00:28 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 19A994056D;
 Tue, 27 Oct 2026 10:00:40 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 27 Oct 2026 10:00:39 +0800
Message-ID: <01b1ac92-e2f7-41d2-8b26-10bba7d3d197@huawei.com>
Date: Tue, 27 Oct 2026 10:00:39 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: |WARNING| argparse: support range step for corelist parsing
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dpdklab@iol.unh.edu>, <test-report@dpdk.org>, "dev@dpdk.org"
 <dev@dpdk.org>
References: <<20261016093001.9067-1-fengchengwen@huawei.com>
 <20261016101228.123E46051830@postal.iol.unh.edu>
 <73b5e9cd-6789-422a-9679-88693c60352b@huawei.com>
 <20261019091940.5f31d146@phoenix.local>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261019091940.5f31d146@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 12:19 AM, Stephen Hemminger wrote:
> On Mon, 19 Oct 2026 16:36:12 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
> 
>>> When `step` is large and `min + step` exceeds `INT32_MAX`, the loop counter wraps around to a negative value, creating an infinite loop. The variables `min` and `max` are `int` (32-bit signed), and `step` is `int32_t`. If a malicious or mistaken user provides input like `"0-100:2147483647"`, the addition `min += step` will overflow after the first iteration.  
>>
>> False positive, the:
>> 		errno = 0;
>> 		idx = strtol(value, &end, 10);
>> 		last = end;
>> 		if (errno || idx > UINT16_MAX) {
>> 			ARGPARSE_LOG(ERR, "argument %s contains a numerical value out of range!",
>> 				arg->name_long);
>> 			return -EINVAL;
>> 		}
>> already treat such input as an error.
> 
> Since non-negative steps don't make sense, I would use strtoul() instead
> and bound it by MAX_LCORE

Hi Stephen,

Thanks for your suggestion.

While using strtoul() and bounding by MAX_LCORE sounds logical, I prefer to keep
the current implementation for the following reasons:
1. Current validation is already safe: if using strtoul() we should also keep
   "
		if (!isdigit(*value)) {
			ARGPARSE_LOG(ERR, "argument %s has an unexpected non digit character!",
				arg->name_long);
			return -EINVAL;
		}
   "
   because we don't want "+1" as a valid input.

   If there has no error, then idx is valid in [0, LONG_MAX], it will never be negative in
   the following execute flow.
2. MAX_LCORE varies across platforms: MAX_LCORE is a build-time configuration that heavily
   depends on the target SoC. On some resource-constrained or specific SoCs, MAX_LCORE might
   be configured to a very small number (e.g., 4). If we enforce MAX_LCORE as a hard limit for
   the step value, it will cause certain valid test cases or generalized step ranges to fail
   prematurely on those platforms, reducing the robustness of the argparse library.

Best regards,
Chengwen

> 

