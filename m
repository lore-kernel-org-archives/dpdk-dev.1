Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E219CFD376
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 09:33:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1A6B40268;
	Tue,  2 Dec 2025 10:33:50 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id E3A58400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 10:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1764668027;
 bh=3DQjJIwa/dFYrBW1d6XpO87iEYEIIDjFBOTTq/oo4P0=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=noV2kSZtuw7LK/RW++KFxJww7fbgJSOKq5Jxdlx4f8eNBlOxGna6AIRckOGqU1lR6
 gO8UZXJZ0AhiGAPtaYb9mROGGUWiaI/Q/a69X7HRusMIdC4JGuW1pXq5Wy2iTZGbqc
 FPEFBAoiSI/B98sRIWjKm6/85LFdVqglosPlNpq0=
X-QQ-mid: zesmtpsz3t1764668024t2b89522e
X-QQ-Originating-IP: DK08onkpShf9QDPKm5vgDiE4FoTCGScrK2nyE+Gxjv4=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 02 Dec 2025 17:33:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4954150243649707492
Message-ID: <E843958C56F8D7ED+1e84eef5-efc2-423e-adbe-c4069eaa1a60@tencent.com>
Date: Tue, 2 Dec 2025 17:33:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]Re: [PATCH v4] acl: support custom memory allocators in
 rte_acl_build
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <db4d85aea29e4549b04750288db649c3@huawei.com>
 <F28176920A8AE2E0+20251201120508.120236-1-mannywang@tencent.com>
 <20251201084209.1439eccf@phoenix.local>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <20251201084209.1439eccf@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NshvC2+mlzw3xS2pDiiX89NHdQYcqqt9W5VG3iwzfG5O00v9ghfb65TM
 8e5L1yJPuWMt7hmU02Xl71bz3ErS4u83C17CP3E2/SvoryOJG+D1FKALEenZ1roVtbvMc3Z
 UzqbR4ZwEw9NXPQZjOeTN9FfPdjetxXE8QkKSdXsBYcyycyBSjLFpoPeYzweYCurL1c/j+4
 hCh8kY64wKeO8s5YBoE7yQ3lqhV39MQBCzHhMEIFB5mxWt88i4LDGit26I0mQCwY2ndY6Je
 Z15DZB5L3EX5+ejpzpK75ty6dQd0xHFs++6mhYU9XicW45SX8H3vMPoRBXKOExTIih32xuz
 IKsIbZFoaWvYSFjdn26TuxpqstRxMEmTN7OKQKeQhLGnL9gzlABkIOQ/rMA9rz49eBe3N5K
 gsU8R/ihEKD+rbWJVqbwW3YDBaku0SzXCrj6XTXwEgGrM9lgrRUxTj8q71S4rONtlhtdJwO
 RZu2SqBCDIMa4lIQdgixKDw//cB+zo+ZNfJs8j9i1IowLx66290SVtfzi8G4iJess8Evpum
 Gs0osVY7G3R292RnbXnbVh9fMzZff9/0HzCvxbs8V14skoWvT3C8M8qiQjyoRe6S+ZN2Wlu
 U32I6v5sGDVVtcN3FqfadfO/XYBpPquAaxedW7UKd8xb3/p+BB2mZB9d2fbtgTm3Sd0ghez
 ho9tzrCrkWgmmxNz1uY4AxmHIiWnE0+UQxOsJaPKZOI/wMVT+w88x6y59YsTsSfFHrVgPXe
 by6VvonVvrQvRIodBi54hmuDVu7HubWiOAw2HeOM7d1H4uGCtG7Nb3KuwSodFK11pPR/UTg
 ALqNf9R3YuyCAylyKsR3qL0Lj6QCk70LEZd8cKNBEOicmIH5eki5/gtpb0Zecydx1qtec9I
 /DJQhscwFgA/JJJtxVnP3wGt+Y/oLMi/mMYca0K5t39tVoSoTVZ7d9CUqEAVgaCj9Dva/7f
 pNblKKef0C81RxqY4Rhs2DNvju8+/EG+9KnOB85c5s8kmhA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
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

Thanks a lot for your review and feedback.
The comments have been addressed in this version.

On 12/2/2025 12:42 AM, Stephen Hemminger wrote:
> On Mon,  1 Dec 2025 12:05:07 +0000
> "mannywang(王永峰)" <mannywang@tencent.com> wrote:
> 
>> +static void *running_alloc(void *udata, char *name, size_t size,
>> +	size_t align, int32_t socket_id)
>> +{
>> +	(void)align;
>> +	(void)name;
>> +	(void)socket_id;
> 
> Please use __rte_unused attribute or RTE_SET_USED() macro for this.
> 


