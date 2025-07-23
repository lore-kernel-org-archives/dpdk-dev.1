Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B9EC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 01:31:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FC5F402CA;
	Wed, 23 Jul 2025 03:31:06 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B50D14026D
 for <dev@dpdk.org>; Wed, 23 Jul 2025 03:31:04 +0200 (CEST)
Received: from debian (unknown [78.109.70.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 2219BE0568;
 Wed, 23 Jul 2025 05:31:04 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 2219BE0568
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753234264;
 bh=GLZoyD6LEzudVEECbmf+j/YepIJAYvLXwF/laCZgcHo=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=6SpqhCmW9+Vf760M8pFZkD27UYuk6NsRl5tQkc8JGJhYe5qMGp5sU2py0rCJcwDOo
 xN+0V/OB7DrPicUDbaMLiRepewWanMoDLNEoQnvo/+qMXnD+bQUq78QRCT48eVnG8X
 8mnqzyLJrTAVJc/WLQgz3SA/c8Iyu1xPTUZ60JTyytmOBxhFmv77e48OlMU/n2hp8w
 K7pAXoZFHSyozRej/7PHHWftcy8k70zhNR9YRiixlCLa31Im6I41yUXjgdGmtj0LzZ
 HaMBLxW9z8fEnCMhxjmJBNrV71komFPcq45r+9M0BdZlqwwWj4FPyKb978ugc9W56o
 XGp4mndeRg12w==
Date: Wed, 23 Jul 2025 05:31:03 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v6 03/13] test: add test for hotplug and secondary process
 operations
In-Reply-To: <20250722173552.184141-4-stephen@networkplumber.org>
Message-ID: <7f61a6f8-e381-95e6-d362-208444d89923@arknetworks.am>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
 <20250722173552.184141-4-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hi Stephen,

(please see below)

On Tue, 22 Jul 2025, Stephen Hemminger wrote:

> Use null device to exercise ethdev start/stop in secondary process.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> app/test/test_mp_secondary.c | 51 +++++++++++++++++++++++++++++++++---
> 1 file changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
> index f3694530a8..09611cc5c2 100644
> --- a/app/test/test_mp_secondary.c
> +++ b/app/test/test_mp_secondary.c
> @@ -15,6 +15,9 @@
> #include <string.h>
> #include <unistd.h>
>
> +#include <rte_ethdev.h>
> +#include <rte_bus_vdev.h>
> +
> #ifdef RTE_EXEC_ENV_WINDOWS
> int
> test_mp_secondary(void)
> @@ -204,6 +207,44 @@ run_object_creation_tests(void)
> 	return 0;
> }
>
> +static int
> +run_ethdev_tests(void)
> +{
> +	char vdev_name[] = "net_null";

Perhaps 'const'? I don't insist.

> +	struct rte_eth_conf dev_conf = { 0 };
> +	uint16_t port;
> +	int ret;
> +
> +	printf("### Testing hotplug and ethdev start/stop\n");
> +
> +	/* use hotplug to make a null vdev */
> +	ret = rte_eal_hotplug_add("vdev", vdev_name, "");
> +	TEST_ASSERT(ret == 0, "Hotplug add of '%s' failed", vdev_name);
> +
> +	printf("# Checked hotlug_add OK\n");

Could be a typo: hot'p'lug_add.

> +
> +	ret = rte_eth_dev_get_port_by_name(vdev_name, &port);
> +	TEST_ASSERT(ret == 0, "Lookup vdev '%s' failed", vdev_name);
> +
> +	ret = rte_eth_dev_configure(port, 1, 1, &dev_conf);
> +	TEST_ASSERT(ret == 0, "Configure port %u failed", port);

I may be very wrong here, but if this code is supposed to be run in the
secondary process, then is 'rte_eth_dev_configure' allowed in such?

> +
> +	ret = rte_eth_dev_start(port);
> +	TEST_ASSERT(ret == 0, "Start port %u failed", port);
> +
> +	printf("# Checked rte_eth_dev_start\n");
> +
> +	ret = rte_eth_dev_stop(port);
> +	TEST_ASSERT(ret == 0, "Stop port %u failed", port);
> +
> +	printf("# Checked rte_eth_dev_stop\n");
> +
> +	rte_eal_hotplug_remove("vdev", vdev_name);
> +
> +	printf("# Checked hotlug_remove OK\n");

Could be a typo: hot'p'lug_remove.

Thank you.

> +	return 0;
> +}
> +
> /* if called in a primary process, just spawns off a secondary process to
>  * run validation tests - which brings us right back here again...
>  * if called in a secondary process, this runs a series of API tests to check
> @@ -212,15 +253,19 @@ run_object_creation_tests(void)
> int
> test_mp_secondary(void)
> {
> -	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> +	int ret;
> +
> +	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
> 		return run_secondary_instances();
> -	}
>
> 	printf("IN SECONDARY PROCESS\n");
> +	ret = run_ethdev_tests();
> +	if (ret != 0)
> +		return ret;
>
> 	return run_object_creation_tests();
> }
>
> #endif /* !RTE_EXEC_ENV_WINDOWS */
>
> -REGISTER_FAST_TEST(multiprocess_autotest, false, false, test_mp_secondary);
> +REGISTER_FAST_TEST(multiprocess_autotest, true, true, test_mp_secondary);
> -- 
> 2.47.2
>
>
