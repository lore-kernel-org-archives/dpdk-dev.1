Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06983CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 23:26:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D86984026D;
	Tue, 11 Nov 2025 00:26:16 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DC9974026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 00:26:14 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 816A22F;
 Mon, 10 Nov 2025 15:26:06 -0800 (PST)
Received: from [10.122.38.161] (unknown [10.122.38.161])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 167703F5A1;
 Mon, 10 Nov 2025 15:26:14 -0800 (PST)
Message-ID: <258b82d6-5042-449e-88dc-941524a0b0e8@arm.com>
Date: Mon, 10 Nov 2025 17:26:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib/ring: do not allow zero size ring
To: Isaac Boukris <iboukris@gmail.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org
References: <20251110222827.575488-1-iboukris@gmail.com>
 <20251110231546.576516-1-iboukris@gmail.com>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20251110231546.576516-1-iboukris@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 11/10/25 17:15, Isaac Boukris wrote:
> this might happen when for instance the ring size is read from
> config, and would cause runtime crash.
>
> Signed-off-by: Isaac Boukris <iboukris@gmail.com>
> ---
>
> v2:
> * move the fix to the POWEROF2 macro itself.
> * fixed style in the test code.
>
>   app/test/test_ring.c | 7 +++++++
>   lib/ring/rte_ring.c  | 2 +-
>   2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/app/test/test_ring.c b/app/test/test_ring.c
> index ba1fec1de3..3078348b2f 100644
> --- a/app/test/test_ring.c
> +++ b/app/test/test_ring.c
> @@ -505,6 +505,13 @@ test_ring_negative_tests(void)
>   	struct rte_ring *rt = NULL;
>   	unsigned int i;
>   
> +	/* Test zero size ring */
> +	rp = test_ring_create("test_zero_size_ring", -1, 0, SOCKET_ID_ANY, 0);
> +	if (rp != NULL) {
> +		printf("Test failed to detect zero size ring\n");
> +		goto test_fail;
> +	}
> +
>   	/* Test with esize not a multiple of 4 */
>   	rp = test_ring_create("test_bad_element_size", 23,
>   				RING_SIZE + 1, SOCKET_ID_ANY, 0);
> diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
> index edd63aa535..0a9fc31530 100644
> --- a/lib/ring/rte_ring.c
> +++ b/lib/ring/rte_ring.c
> @@ -47,7 +47,7 @@ EAL_REGISTER_TAILQ(rte_ring_tailq)
>   		     RING_F_MP_HTS_ENQ | RING_F_MC_HTS_DEQ)
>   
>   /* true if x is a power of 2 */
> -#define POWEROF2(x) ((((x)-1) & (x)) == 0)
> +#define POWEROF2(x) ((x != 0) && (((x)-1) & (x)) == 0)
>   
>   /* by default set head/tail distance as 1/8 of ring capacity */
>   #define HTD_MAX_DEF	8

Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>


