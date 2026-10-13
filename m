Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CABCA9ED2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 12:16:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F99C402DA;
	Tue, 13 Oct 2026 14:16:28 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 5BD35402A4
 for <dev@dpdk.org>; Tue, 13 Oct 2026 14:16:26 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D4B431400163
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:16:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 13 Oct 2026 08:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791893785;
 x=1791980185; bh=hJIOaSaaqL4nyAOkt6UNcSQ19K8ojDJV8Xu44Z70ZCg=; b=
 iIArvTdEr3XYaQUeyjPWXV6567igpFFiUboIhnzkpNgybHbMbCMrfatGP+KZRYgo
 XH25/qrvmBgATg3SvKSLDNvJ0CNQEGQRyP7kDUvkYdjNN4dM79aDU+3TNItvAFDv
 v0C+7mpewEiB73yItzniZAme80u2aRaXWcvLSoXM32SbrygrfSrzh+Y2SeysyWQH
 wWhI1ypb1HjfeogqtNnsM9fO2hYvZgofADFKnXzKhJ+RMuAMAI+PszLEoVo9aLLv
 Mu7jmE+CuEXQHVhUqcghIwe2O19ZubAsP4n3KJqbQDVr65XXekivMvpFv5JKwROW
 cNGCytRfkpMAgJv5ZjWPlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791893785; x=
 1791980185; bh=hJIOaSaaqL4nyAOkt6UNcSQ19K8ojDJV8Xu44Z70ZCg=; b=M
 a2hP/eeJfZfD2OmQCnrLl/OGmTz+4DuuTxXcKV2Ix7N3oQYg22CdIjqjH0519Zdy
 Bzb8eflYz+Rftj9nMVjpHUziDXXhZRUx6Ls6wmEENDQH3kq5ZT+HsAFNJzYKnvGI
 /Z5R4lINjU8bqhvJRNa+4JA9dqDa0ejdMTlFRpnTD3MnuDNWsrUniERuYEnaX1DY
 HzdrcjxYT+qdbEd94iCVJwTLgY6+1oNgcGERitTYQiUO1z4v864+m/sSW/qK2JU5
 IPBcAdRe71zWgKXjNE+mxQdsChEetkNlY6jj8mEsbfv4/DR3GvJX1rB+JRXmiOH7
 q/T9qzk7QuE1Ty6bJY7kQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791893785; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:ZN79ALcXZv5tvVx4td+3vkICKYonsJl+zdSKGIRk/8O2ce8
 JOU+0mfnAl1xy6c1bWeQXCmvQ6sqgfwhXOVBTjidYJE5y7CdxWKb/RtrZ/81VHfp
 3bfMzSEp3ToPAadAoSs8xASOVRDe6OkdatOLKP7jd8Z3RoYTwmisC67i87s0kaaG
 nOF7obb8MsnjhJcjU12rO+WxjnoAed6ZM+rvkOusKAZ+iAYo1OTXRBIJWHmVApWV
 B3ZmxWXzr/sAiICHMdY6Or8afp8rtEF7zFrnXqRCZRObmKXavMSqTo3AeCsUzF38
 H5YqEjv1cqTivrcyT3B7hyAyGKeaCT4viCF+efQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:L97bXdewOAen4QiZmyfxqxSb33M8Ulbu+Venn3OWEVI=:r6qP/lgMQ1B1JqtnNxsR7EO8cw83MEN5ukgjvs/tMjc=;
X-ME-Sender: <xms:GSHOamMoarvbhiSGhVhLqYkXzRbPU7lHbebVxC2zKkm92CTsqIGuxw>
 <xme:GSHOavCDDZThJUwJjX0DJZ8gTAfLJ1-p2FEAFiRtR4C6ADWEyeJFq-YY3XG1rqISB
 HCMVqaNyQirnU7IIis5t_-K2HT0DbTRyf5vVo5j3T5posqT9xEeJ7E>
X-ME-Received: <xmr:GSHOatIoZWN7DgQUfLPN_1UwjD1CIl35hvte8CRULAVUPM9CLXbeYpF3QUPWe0XuC52ixj3e6nkgvDeLLpQ9-qg>
X-ME-Proxy-Cause: dmFkZTFD7F53U7zKqlrSE+rBZYeZErUfIQqNm3LqHwPrJ3VaUSmF1pfHXxZ2UHwR1Cy20P
 SKQLqAOXMRTshLr6dFB/jkjbaK9cwqvzcXYDoQA+55qJXh8vd1Q6ThriTyi+9Ji8OYeckf
 jjXDdwjcxdkEQD9le1AF1uT8HVTT64uFBO0als8cHL/Qtoxa38vkMchp8BTeDv0BGB8Hb0
 IxG/Zn/kr+ma7ikmNeRgIybwBlKeEUJ928hJ2RFfJsgsSfR+rxwFhGn+kZxigXLf0FzATM
 309IF3JgiuvqbfTZLVeercEPgt0gTw8p16GEmL8W7861KbMIpUfoNxzgK+OpWR8EE5zaH9
 h9mgNjKJ3AG+yg+rCid/75GCuXjOGlWUeCoU092lHI0HcHU1a4EOoN1A48M3aQxAYwSRL1
 qQabeD6BiEHWD9eVXCyRzXA6JHxpLMqjO1Pi0WXUrWAC9U5U3NsNwwFjTSkq62qLPvP4Vk
 cQx677K2SNr98ZUs6kHUD3wHMuvso2rvj1rtdZjq6u7D4mQZPywevu7OBcLdAKWc2ZVXHZ
 1T7UR1teVk4vSvgrSAmzfQTuYCjpIdUeJhsZU5cMHRrdnyhM4KHfpoHjAdZpxAMHMTn7iS
 h8LKOZ/1WawnL/z3YTCDEXV6bohk/EDQXePswwNmBuhU27mAer8yaTzCiV8A
X-ME-Proxy: <xmx:GSHOaoMIwICQaht5aqjMe5KPS__m17aFD1O6ak0nFHG65VqtwQJkJQ>
 <xmx:GSHOar4Pul-Q-mMj2nSmEPVvtn8YVAMV8Qg3bv_4sHfPi657t_4ApA>
 <xmx:GSHOaq6FbqhaIG2-V-dBO90ubo6g_uWgiyZkFwCYwotsNrJqrzIr3A>
 <xmx:GSHOapHNz0s78xlArruw8wMK9xZ8AxaqJ35qSJeIZpooOZ1tdDWyAg>
 <xmx:GSHOaisEzQBkpc5kmFiaH7MqxBn2w4zK-3W-oUZw0eFqb6NB1MNCReSC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 08:16:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com, dev@dpdk.org,
 stephen@networkplumber.org, fengchengwen@huawei.com, yangxingui@huawei.com,
 zhanjie9@hisilicon.com
Subject: Re: [PATCH v5 0/6] power: uncore power improvements and auto-detection
Date: Tue, 13 Oct 2026 14:16:21 +0200
Message-ID: <DSIOcMdaRbaWDsHOG6v2jA@monjalon.net>
In-Reply-To: <20260812094956.3356537-1-lihuisong@huawei.com>
References: <20260812094956.3356537-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

> Huisong Li (6):
>   examples/l3fwd-power: fix uncore deinit for non-legacy
>   examples/l3fwd-power: enable power QoS for all modes
>   examples/l3fwd-power: fix uncore help and log info
>   examples/l3fwd-power: relocate uncore initialization
>   power: support automatic detection of uncore driver
>   power: remove unused auto-detection uncore

Applied, thanks.


