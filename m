Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9CFCD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 14:24:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 606CB4021F;
	Thu, 28 May 2026 16:24:43 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id E1CEE4003C
 for <dev@dpdk.org>; Thu, 28 May 2026 16:24:41 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4C950140014A;
 Thu, 28 May 2026 10:24:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Thu, 28 May 2026 10:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779978281;
 x=1780064681; bh=KzEd1sNlZIiHLvaPl/sFkCTWpvyM1JLAG851xPOpCp4=; b=
 ZyTI34gLfJkXRdkYECYOsoH08P6EoncLVqYt+MaiSpsS9afJl/+52U6OcU/RHxp4
 Uoy+Tr7YZcIzdsESXWET6k3FPKuW5Uoa4cSr8CTY0uF16myb2X7MWNg9oqHHtqGK
 x1G8Sc4paZlz/aKmKIY3eQP8PbNmXTKensSIc6ho5ifgEtXh8SkmmlqwyT+evv4M
 6Em5NptNO7ef1nhMDiYRCvbcMUk2n5uvi3H2nVnZ0ccJD2Zm3J13KEaGAbTlL/Ol
 lbTQdHbIrqzML+DC+60OnBXUKDfQtY9w4nMH4FAqBRKp3fSjDH3fAe4Zjv1lEipf
 WVCHXdls3ZAcS75QAUoPZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779978281; x=
 1780064681; bh=KzEd1sNlZIiHLvaPl/sFkCTWpvyM1JLAG851xPOpCp4=; b=V
 pupvD/D94AtOImb5MCIy1PE6D+ykbJi5EK028FZjF47XQlcrLgSEswzli1DIVWZu
 zyE5REs9kbKy1Pr9IcZKgY+nKejDrMv4xDRDFQyWY9QvUgqpzAzQF7g1ZypvJH7H
 EKMwzl/7uwNJu7vmn2HCHONVsrZ6lbg5FxAZAAPX3i57tETDq7xUrDKsL1XtD6TF
 G/pjsONtmPTZXX3rdW2YGywDhn9tAEjrZMXTuJFyNZ0m7QpGWaYAfC1CsK0YBNkt
 y9x7TIZ5x1FvVCsFad+d8kQEnJSUKvnqn+ERuCjnmomu7IJYrTarY+Nf+7tKsTnq
 VULqbqL4SBseqTM/ZU59g==
X-ME-Sender: <xms:KFAYamKVivHNZsW-i8fIblWPTRt6uXfyE4KgBhrfPHHBZlyRe746CA>
 <xme:KFAYaieSJ6r4Q9LM8xf58-Q5X70NIJfH8Ez_PUbPq-4jlsc5Fg66IjR1by9w3-Tg2
 xBYbtcbhCcJfSZG-0_4iD8BpodxtUbmdpYgu6NGmRjVvWSyLyzseA>
X-ME-Received: <xmr:KFAYal33sGm2RDyUmlegFapKc4Em1hItQoQ_FwgDLKPPzWzzDFTHt2W4et2YXyx_XLdb4Kxb80aeE9s1kiIjVK01Mg>
X-ME-Proxy-Cause: dmFkZTGF/w26OW6KnC+IHPnRFRqyH7+3lZekw7hvG7IXlyEndFAl9/NV/sjbwN2TI5Oinu
 5ZQ9UDDuQe/bHRDJ5SZwd0YHFsNYDNc6ueAX1TxMtQPtvLBDCsTapJo/GlTyaCLfuFrHQm
 6W82hdxRzHwxnWRTcmVXcvEwDgji6LQry9zSy+gVOpWxW/BmwBYl2l9VnGxqhBZPiy4d2j
 VIDBfWWjCvquTX9UVm5z3MV7jxVQzwU1bExwmCfXY2GtTgXbS6i9vOqXsvhueCeYIwNrSW
 5uS023jPsL+9zfMAnyDwtEZ7d9XO36QVdaClhYe0VXfWq7xEokoSKsIkAwWaNP9eQrKLlV
 fdvau9qj2NHQ9DtdroGLpvxnHqOev6uz9QarKWEMADLH+wY2HrH5Dq8yEyyc1gB3N3K5m1
 Sgs0FPiw6FbMm4u8+w7WzUe8byAf3AJDgALg5nfPiEcN69+x8lNDI0Lwb4ZdJMLhmJUUAA
 0pmOp1EAHNYmXPrC7wsRaIz1uZNwxrPaXIiA1t6bijU+3/xdIH0+rJUU6U9zEojnfKPetn
 kp8vcLOx7Ap4QG83yqLDqz4zONnRfkpnaynKdj1DdsKBg71MTlppRhwvXgvsqArD/oQvoU
 YgtXFeNtrv/E3SucHF2BEJzcccmVZmViDQO/0w54hmEhvU6o2nxNk6g4jkIA
X-ME-Proxy: <xmx:KFAYajjYJGA9TO4Sn4BlBoDI0yUO4V5ySa9UyypOcZSN4xGZl1o35w>
 <xmx:KFAYajRoECIMZmlJtgIXBiEqScRCEGgVPmXHD_ilkD3I-fV70ywGGA>
 <xmx:KFAYasiZVU9BB0BbZ01x55ZfzHQQUq9G-BJ8arWxIsvJryATTKH11w>
 <xmx:KFAYar6lXU6dyxnFA2cGTbJIhLAvd3mf9PedR5SpYZXaV4NkFRqVeA>
 <xmx:KVAYajKwcjmkFMNU2RJ26f7nOSFoIs7nDPxkowLQlpdEel74Z6PiJvoH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 10:24:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Jianfeng Tan <jianfeng.tan@intel.com>
Subject: Re: [PATCH v1 4/5] eal: fix async IPC resource leaks on partial
 failure
Date: Thu, 28 May 2026 16:24:38 +0200
Message-ID: <3K0aB9xhSMWITv5e_T4_Ig@monjalon.net>
In-Reply-To: <af8325076295d7f5400d6ff19451ea54828b63e9.1773936429.git.anatoly.burakov@intel.com>
References: <af8325076295d7f5400d6ff19451ea54828b63e9.1773936429.git.anatoly.burakov@intel.com>
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

Hello Anatoly,

19/03/2026 17:07, Anatoly Burakov:
> Use a numeric request ID for alarm callback lookup so stale callbacks
> from rolled-back requests become harmless no-ops.

It seems you forgot to convert 2 calls to rte_eal_alarm_set().

[...]
>  struct pending_request {
>  	TAILQ_ENTRY(pending_request) next;
> +	unsigned long id;
[...]
> +static struct pending_request *
> +find_pending_request_by_id(unsigned long id)
> +{
> +	struct pending_request *r;
> +
> +	TAILQ_FOREACH(r, &pending_requests.requests, next) {
> +		if (r->id == id)
> +			return r;
> +	}
> +
> +	return NULL;
> +}
[...]
>  async_reply_handle(void *arg)
>  {
>  	struct pending_request *req;
> +	/* alarm arg carries the request ID packed into a void * via uintptr_t */

No, that's wrong.
The pointer passed in some rte_eal_alarm_set() from patch 2
is a struct pending_request.

> +	unsigned long id = (uintptr_t)arg;

Either you get the id field from arg,
or you pass dummy->id to rte_eal_alarm_set().

>  	pthread_mutex_lock(&pending_requests.lock);
> -	req = async_reply_handle_thread_unsafe(arg);
> +	req = find_pending_request_by_id(id);
> +	if (req != NULL)
> +		req = async_reply_handle_thread_unsafe(req);
>  	pthread_mutex_unlock(&pending_requests.lock);



