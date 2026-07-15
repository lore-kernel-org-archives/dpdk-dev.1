Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7D6C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 08:03:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7994640290;
	Wed, 15 Jul 2026 10:03:58 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 920BE4028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 10:03:56 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XgVaUU7XpRzzpbYnuidBLDrT4y5+a6Q+ufBMu3enxPs=;
 b=PFvwmAoHA1j/+ojl/9mzRQf9FwwhnqfLQvx89mosnPtrgY+1YIl5cLdXr0m5DwsgJULl6oMi0
 TSiRwws1z542PCNptNOYTmp6sSdTF/v5Z0eWsyRD3LfJug2xR/lHfT8vzn5zyM26bQWJhA8Qw01
 9si+QTvyB90bKTZjXPBncWY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h0T3Q1zTRz1T4LH;
 Wed, 15 Jul 2026 15:54:42 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id CC2DE4057D;
 Wed, 15 Jul 2026 16:03:52 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 15 Jul 2026 16:03:52 +0800
Message-ID: <7ce41207-c13f-4c35-8303-119d8241f74f@huawei.com>
Date: Wed, 15 Jul 2026 16:03:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmadev: clarify last_idx documentation for completion
 APIs
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Kevin Laatz
 <kevin.laatz@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, David Marchand <david.marchand@redhat.com>, Thomas
 Monjalon <thomas@monjalon.net>
References: <20260715060630.3450172-1-raghavendra.ningoji@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260715060630.3450172-1-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Apart from the comment for the last_idx field, I think the others also
need to be updated.

Based on your v2, I have refreshed the comments for these two functions.

/**
 * Return the number of operations that have completed successfully,
 * starting from the current ring position.
 *
 * This function reports a contiguous run of successfully completed
 * operations. It stops at the first operation that either failed or
 * has not yet completed. Once an operation is reported as successfully
 * completed, the results of that operation are visible to all cores
 * on the system.
 *
 * @param dev_id
 *   The identifier of the device.
 * @param vchan
 *   The identifier of the virtual DMA channel.
 * @param nb_cpls
 *   The maximum number of completed operations to report.
 * @param[out] last_idx
 *   The ring_idx of the last successfully completed operation reported
 *   by this call. The function stops at the first failed or incomplete
 *   operation, and reports at most nb_cpls operations, so this may not
 *   be the last successful operation the device has actually completed.
 *   If not required, NULL can be passed in.
 * @param[out] has_error
 *   When set to true, a failed operation was encountered among the
 *   completed operations on the device (within the nb_cpls limit),
 *   causing the function to stop early. The returned count covers
 *   only the successful completions preceding that first failure.
 *   When false, all operations reported by this call succeeded;
 *   the function stopped either because nb_cpls operations have been
 *   reported, or because no more completed operations are available on
 *   the device.
 *   If not required, NULL can be passed in.
 *
 * @return
 *   The number of operations that successfully completed. This
 *   return value is less than or equal to the value of nb_cpls.
 */
static inline uint16_t
rte_dma_completed(int16_t dev_id, uint16_t vchan, const uint16_t nb_cpls,
		  uint16_t *last_idx, bool *has_error)


/**
 * Return the number of operations that have completed (successfully
 * or with error), starting from the current ring position.
 *
 * This function reports all completed operations up to nb_cpls,
 * regardless of whether each individual operation succeeded or
 * failed. Once an operation has been reported as completed
 * successfully, the results of that operation are visible to all
 * cores on the system.
 *
 * @param dev_id
 *   The identifier of the device.
 * @param vchan
 *   The identifier of the virtual DMA channel.
 * @param nb_cpls
 *   The size of the status array, i.e. the maximum number of
 *   completed operations to report.
 * @param[out] last_idx
 *   The ring_idx of the last completed operation reported by this
 *   call, whether successful or failed. The function reports up to
 *   nb_cpls completed operations without stopping on errors, so this
 *   may not be the last operation the device has actually completed.
 *   If not required, NULL can be passed in.
 * @param[out] status
 *   Pointer to an array of length 'nb_cpls' that receives the
 *   completion status code of each reported operation.
 *   @see enum rte_dma_status_code
 *
 * @return
 *   The number of operations that completed. This return value is
 *   less than or equal to the value of nb_cpls.
 *   If this number is n (n > 0), the first n entries in the status
 *   array are valid.
 */
static inline uint16_t
rte_dma_completed_status(int16_t dev_id, uint16_t vchan,
			 const uint16_t nb_cpls, uint16_t *last_idx,
			 enum rte_dma_status_code *status)

You can send a v3 version based on this.

Thanks

On 7/15/2026 2:06 PM, Raghavendra Ningoji wrote:
> The last_idx output parameter was documented identically for
> rte_dma_completed() and rte_dma_completed_status(), even though the two
> APIs have different semantics:
> 
> - rte_dma_completed() only reports operations that completed
>   successfully and stops at the first error, so its last_idx is the
>   ring_idx of the last successfully completed operation.
> - rte_dma_completed_status() reports all completed operations regardless
>   of status, so its last_idx is the last completed operation's ring_idx
>   irrespective of success or failure.
> 
> In both cases only up to nb_cpls operations are reported per call, so
> last_idx is the ring_idx of the last reported operation, which may not
> be the last operation the device has actually completed.
> 
> Clarify both descriptions to remove the ambiguity.
> 
> Fixes: 91e581e5c924 ("dmadev: add data plane API")
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
> v2:
>  - Clarify (per Bruce Richardson) that last_idx is the ring_idx of the
>    last operation reported by the call, bounded by nb_cpls, which may not
>    be the last operation the device has actually completed.
> 
>  lib/dmadev/rte_dmadev.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
> index 81dfe187e2..76b0dd6a1b 100644
> --- a/lib/dmadev/rte_dmadev.h
> +++ b/lib/dmadev/rte_dmadev.h
> @@ -1338,7 +1338,9 @@ rte_dma_submit(int16_t dev_id, uint16_t vchan)
>   * @param nb_cpls
>   *   The maximum number of completed operations that can be processed.
>   * @param[out] last_idx
> - *   The last completed operation's ring_idx.
> + *   The ring_idx of the last successfully completed operation reported by
> + *   this call (at most nb_cpls operations are reported, so this may not be
> + *   the last operation the device has actually completed).
>   *   If not required, NULL can be passed in.
>   * @param[out] has_error
>   *   Indicates if there are transfer error.
> @@ -1397,7 +1399,10 @@ rte_dma_completed(int16_t dev_id, uint16_t vchan, const uint16_t nb_cpls,
>   * @param nb_cpls
>   *   Indicates the size of status array.
>   * @param[out] last_idx
> - *   The last completed operation's ring_idx.
> + *   The ring_idx of the last operation reported by this call, regardless of
> + *   whether it completed successfully or with an error (at most nb_cpls
> + *   operations are reported, so this may not be the last operation the
> + *   device has actually completed).
>   *   If not required, NULL can be passed in.
>   * @param[out] status
>   *   This is a pointer to an array of length 'nb_cpls' that holds the completion

