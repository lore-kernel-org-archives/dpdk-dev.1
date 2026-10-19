Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87711606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=kRIx4Odi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C957540297;
	Mon, 19 Oct 2026 23:22:57 +0200 (CEST)
Received: from forward501e.mail.yandex.net (forward501e.mail.yandex.net
 [93.77.172.86]) by mails.dpdk.org (Postfix) with ESMTP id BF4684021E;
 Mon, 19 Oct 2026 23:22:55 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-11.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-11.yp-c.yandex.net)
 by forward501e.mail.yandex.net (postfix) with ESMTPS id 4EA55C0080;
 Tue, 20 Oct 2026 00:22:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-11 with ESMTPSA id
 oMhZToaeO4Y0-chMF9PX3; Tue, 20 Oct 2026 00:22:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792444973; bh=dQ9/WEmmzwqxksReMMzlsQ2iNZL/IBHUd8wsdc8BcZA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=kRIx4OdifzDLGVKSFf+A0AWa/c081FxKXITWMoq7ar18psRoWLxLDOEayh9O3Am/R
 7cS9q+P7e4zhtudtti3hqiuN8jiLEgiKLP5LGy8nC2FsPver3VUg4q+IOeJtzpj/jh
 xggWfWbEcNCVK287D/u1jv5OeXXs0saD1EsDU1wg=
Authentication-Results: mail-nwsmtp-smtp-production-main-11;
 dkim=pass header.i=@yandex.ru
Message-ID: <a578685e-9312-4d30-8fca-58ba6ec91e94@yandex.ru>
Date: Mon, 19 Oct 2026 22:22:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] bpf: reject Tx callback installation with
 MT_LOCKFREE
To: Marat Khalili <qm2k21@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, stable@dpdk.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-4-qm2k21@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261012210917.161343-4-qm2k21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1




> The BPF ethdev packet callback synchronization mechanism expects only
> one dataplane thread per port/queue pair at a time. When
> RTE_ETH_TX_OFFLOAD_MT_LOCKFREE is enabled, multiple threads can invoke
> rte_eth_tx_burst() concurrently on the same queue without locks. This
> breaks the callback parity counter and can lead to use-after-free or
> deadlocks during BPF program unload.
>
> Reject BPF Tx callback installation with -ENOTSUP when
> RTE_ETH_TX_OFFLOAD_MT_LOCKFREE is enabled on the port or queue.
> Add a unit test in test_bpf verifying this rejection.

Should we be more generic here and reject any TX callbacks for 
RTE_ETH_TX_OFFLOAD_MT_LOCKFREE devices?
Right now callbacks are not allowed for hairpin queues.
As another thing: AFAIK, ethdev callbacks (both RX and TX) will survive 
dev stop/configure/start sequence.
We probably need to handle both scenarios.

> Bugzilla ID: 2051
> Fixes: a93ff62a8938 ("bpf: introduce basic Rx/Tx filters")
> Cc: stable@dpdk.org
>
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---
>   app/test/test_bpf.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
>   lib/bpf/bpf_pkt.c   |  46 ++++++++++++++++++++
>   2 files changed, 149 insertions(+)
>
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 3205afaa63..02523984b5 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -4617,6 +4617,107 @@ test_bpf_elf_rx_load(load_elf_image_t load_elf_image)
>   	return ret == 0 ? TEST_SUCCESS : TEST_FAILED;
>   }
>   
> +static int
> +null_vdev_mt_setup(const char *name, uint16_t *port, struct rte_mempool *pool)
> +{
> +	struct rte_eth_conf conf = {
> +		.txmode = {
> +			.offloads = RTE_ETH_TX_OFFLOAD_MT_LOCKFREE,
> +		},
> +	};
> +	struct rte_eth_txconf txconf = { };
> +	struct rte_eth_rxconf rxconf = { };
> +	int ret;
> +
> +	ret = rte_vdev_init(name, NULL);
> +	TEST_ASSERT(ret == 0, "rte_vdev_init(%s) failed: %d", name, ret);
> +
> +	ret = rte_eth_dev_get_port_by_name(name, port);
> +	TEST_ASSERT(ret == 0, "failed to get port id for %s: %d", name, ret);
> +
> +	ret = rte_eth_dev_configure(*port, 1, 1, &conf);
> +	TEST_ASSERT(ret == 0, "failed to configure port %u: %d", *port, ret);
> +
> +	ret = rte_eth_tx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY, &txconf);
> +	TEST_ASSERT(ret == 0, "failed to setup tx queue port %u: %d", *port, ret);
> +
> +	ret = rte_eth_rx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY,
> +				     &rxconf, pool);
> +	TEST_ASSERT(ret == 0, "failed to setup rx queue port %u: %d", *port, ret);
> +
> +	ret = rte_eth_dev_start(*port);
> +	TEST_ASSERT(ret == 0, "failed to start port %u: %d", *port, ret);
> +
> +	return 0;
> +}
> +
> +/* Test that installing a Tx filter is rejected when MT_LOCKFREE is enabled */
> +static int
> +test_bpf_elf_tx_mt_lockfree(load_elf_image_t load_elf_image)
> +{
> +	static const struct rte_bpf_arg prog_arg = {
> +		.type = RTE_BPF_ARG_PTR,
> +		.size = sizeof(struct dummy_net),
> +	};
> +	static const char null_dev[] = "net_null_bpf_mt";
> +	struct rte_mempool *mb_pool = NULL;
> +	struct rte_bpf *bpf = NULL;
> +	uint16_t port = UINT16_MAX;
> +	int ret;
> +
> +	mb_pool = rte_pktmbuf_pool_create("bpf_mt_test_pool", BPF_TEST_POOLSIZE,
> +					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
> +					  SOCKET_ID_ANY);
> +	TEST_ASSERT_NOT_NULL(mb_pool, "failed to create mempool");
> +
> +	ret = null_vdev_mt_setup(null_dev, &port, mb_pool);
> +	if (ret != 0)
> +		goto fail;
> +
> +	bpf = load_elf_image(app_test_bpf_filter_o, app_test_bpf_filter_o_len, "filter",
> +			     NULL, 0, &prog_arg);
> +	if (bpf == NULL) {
> +		printf("%s@%d: failed to load BPF filter image\n",
> +		       __func__, __LINE__);
> +		ret = TEST_FAILED;
> +		goto fail;
> +	}
> +
> +	/* Tx installation must fail with -ENOTSUP due to MT_LOCKFREE */
> +	ret = rte_bpf_eth_tx_install(port, 0, bpf, 0);
> +	if (ret != -ENOTSUP) {
> +		printf("%s@%d: expected rte_bpf_eth_tx_install to return -ENOTSUP, got %d\n",
> +		       __func__, __LINE__, ret);
> +		ret = TEST_FAILED;
> +		goto fail;
> +	}
> +
> +	/* Rx installation on the same port must still succeed */
> +	ret = rte_bpf_eth_rx_install(port, 0, bpf, 0);
> +	if (ret != 0) {
> +		printf("%s@%d: expected rte_bpf_eth_rx_install to succeed, got %d\n",
> +		       __func__, __LINE__, ret);
> +		ret = TEST_FAILED;
> +		goto fail;
> +	}
> +	rte_bpf_eth_rx_unload(port, 0);
> +	/* bpf is destroyed by rte_bpf_eth_rx_unload */
> +	bpf = NULL;
> +
> +	ret = TEST_SUCCESS;
> +
> +fail:
> +	if (bpf != NULL)
> +		rte_bpf_destroy(bpf);
> +
> +	if (port != UINT16_MAX) {
> +		rte_eth_dev_stop(port);
> +		rte_vdev_uninit(null_dev);
> +	}
> +
> +	rte_mempool_free(mb_pool);
> +	return ret;
> +}
>   
>   static int
>   test_bpf_elf(void)
> @@ -4633,6 +4734,8 @@ test_bpf_elf(void)
>   			ret = test_bpf_elf_load(elf_image_loaders[li]);
>   		if (ret == TEST_SUCCESS)
>   			ret = test_bpf_elf_tx_load(elf_image_loaders[li]);
> +		if (ret == TEST_SUCCESS)
> +			ret = test_bpf_elf_tx_mt_lockfree(elf_image_loaders[li]);
>   		if (ret == TEST_SUCCESS)
>   			ret = test_bpf_elf_rx_load(elf_image_loaders[li]);
>   	}
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index 4223ef624e..eab85f7417 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -552,6 +552,48 @@ rte_bpf_eth_tx_unload(uint16_t port, uint16_t queue)
>   	rte_spinlock_unlock(&cbh->lock);
>   }
>   
> +/*
> + * Check if the supplied port/queue pair is suitable for BPF callback execution.
> + */
> +static int
> +bpf_eth_check_mt(const struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue)
> +{
> +	struct rte_eth_txq_info qinfo;
> +	struct rte_eth_conf conf;
> +	int ret;
> +
> +	if (cbh->type == BPF_ETH_TX) {
> +		ret = rte_eth_dev_conf_get(port, &conf);
> +		if (ret != 0) {
> +			RTE_BPF_LOG_LINE(ERR,
> +				"%s(%u, %u): failed to get device configuration: %d;",
> +				__func__, port, queue, ret);
> +			return ret;
> +		}
> +
> +		if ((conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE) != 0) {
> +			RTE_BPF_LOG_LINE(ERR,
> +				"%s(%u, %u): MT_LOCKFREE Tx offload is enabled on port;",
> +				__func__, port, queue);
> +			return -ENOTSUP;
> +		}
> +
> +		/*
> +		 * Ignore errors from tx_queue_info_get: the PMD might not implement
> +		 * txq_info_get (e.g. net/null), or the queue might not be set up yet.
> +		 */
> +		if (rte_eth_tx_queue_info_get(port, queue, &qinfo) == 0 &&
> +				(qinfo.conf.offloads & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE) != 0) {
> +			RTE_BPF_LOG_LINE(ERR,
> +				"%s(%u, %u): MT_LOCKFREE Tx offload is enabled on queue;",
> +				__func__, port, queue);
> +			return -ENOTSUP;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
>   	struct rte_bpf *bpf, uint32_t flags)
> @@ -572,6 +614,10 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
>   	if (bpf->prm.nb_prog_arg != 1)
>   		return -EINVAL;
>   
> +	rc = bpf_eth_check_mt(cbh, port, queue);
> +	if (rc != 0)
> +		return rc;
> +
>   	if (cbh->type == BPF_ETH_RX)
>   		frx = select_rx_callback(bpf->prm.prog_arg[0].type, flags);
>   	else

