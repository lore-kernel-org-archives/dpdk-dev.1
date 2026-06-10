Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B69CD98C5
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 22:25:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C957F42E6E;
	Thu, 11 Jun 2026 00:25:58 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id A219C402C9;
 Thu, 11 Jun 2026 00:25:57 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 157A914000B6;
 Wed, 10 Jun 2026 18:25:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 18:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781130357;
 x=1781216757; bh=mwesHUgwbZeFdgI0pr/GTO8IWORnjuPMuOD7BAlg+O4=; b=
 dpr/UsAWcV5Ez4wsdnUkK3CtjAkq1Qvgl0bTd05gSfHQj0J5tjIXrALbWYIZyIje
 LDuxr9BGP9aO7qUsvJbYEi5ssaYLBJaumtpwBSpLjmhf5maYQlUOoBJ5H5vSNiW7
 4c/5oUhsgLOJF2rGXqsKsyOWpek40Hr6ol2lHHVTN4Fj4V1KS0yXpmt7u9qDIOEn
 fz2LRrQXNc699kmiTkmSlyODr1SGVHff189Wcy+vn1ugif6vyyrj9ZGAaHuPUEHq
 sswEFR09EFylLJB7JxO3rHkUwe0YovFWvwpQPQp5FK0GKTHbyVBZHjFtpOFxAJny
 bVaR+s4TpILNHGRYPI443g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781130357; x=
 1781216757; bh=mwesHUgwbZeFdgI0pr/GTO8IWORnjuPMuOD7BAlg+O4=; b=M
 ig6ZK1uTf+da34aNxtvzYNorAPtaRYKI8OyXeyaWGWVzZOT6bjjas/6wrIoXy931
 pWfKGRfUSQiVFj93JDfpP5OE97CtA6LpoYMm5NUvO4hRCxXpkd5BLalIH3nJPqBj
 ASkpsToEf9pWPMBs6fRbWJBHzXcWpaW4Jnz3zuaykC7RZItcIeED/pvQXfzqEBXP
 QbT1pp8/TJnwF/2pyDiA7YtpieZgjoDJZDzLA3ppa9OcHOjDlhj7kWVkGEyv9mLV
 3mJUB8JZwk0A1R7Bk3f1L1bZwVz/jlQspcQm2GGPRE200BxLXk8VAu5yVBx11uIW
 rAWCA0W8he35jo7f4PNNQ==
X-ME-Sender: <xms:dOQpalXOLHGTBlfABQG5wKsvoVjdAKvdwgWq-LqHWFdk3MtVQm9gYQ>
 <xme:dOQpahCGZqxJZkuqoHjzmyBbBLY5D0So0H8coTm4Mzrq6wtQun3XrQy9Qbwg7b3I_
 S0DkJZ6cX7rOzpRnITarwqK0wj2OBixFBpVEmim4HpkbkUHhcuxmTE>
X-ME-Received: <xmr:dOQpak6IxIIuJLxeSb2GgezkZAWUC0_6FilvUVFXkR940ilMw3LkNaKB-4--n-lk8WlvpWunFskuKUaa_Kwuv72jUA>
X-ME-Proxy-Cause: dmFkZTF0QYr0Hdw8IFLyQBJHrJnaHbHYJQW9HczEy76sgCTi4Zk/X8i4DG9E0ulc5A0nN/
 /WB1fGtPsAoBJdBnjpZWOKHmaqaodFf4pN3H2jCpIIEI8EMRxjUa8NzTNi0WsZoa+vCExO
 /67GPsuGpeyEUKJVltDsWQsQ+76CpGdX1hhR9r1gyLQD9mnO3mE0f4Ys55awLntSrN0lMY
 KO+tgk6UV8k3jJYApv24Sibg/0exSS+g9bxwyfSp/aXMtlT6dQdi7k9VFx458wP0KXWhPO
 dUrVTwt0vWBq2xYKdmUFw3UmCslG1tk5Nfe8LbpuDNRgnIohfg8znLgwp2RxhFRuvJy9d6
 wHRiDjCK2CBxXCtTjdP3nHu43tizAfhG7IqtlXJTslKDjCUl1vre15CHYOIz2jtvDphcd8
 /2MoPrpOTCF7Fqit8DQnfoTc1PM4yuR/PDSTELrs+uOFvi5HgXF20bJNxxqAqGnOmCaSbW
 B06c4YpKnKHtDn7NWYjpjGyfi+jJ9zxc5xqner6N8PubRDFfCOB7Pqx67lQvvj3xNTnix1
 5HEHJgY0TtUYY5ixKjDQfg3h0ZXQMpiHYilMvV89Tzcssu3FmW0lmuAlLQfMpynbv1vS7S
 bBM/Qrmd3reACH4BgqalnJgPRmiN3vukf23ASlTxPWolqAVhKADc64jTh1zA
X-ME-Proxy: <xmx:dOQpaswDOaegBQAwFtRH2JIbeaY-hlv2N78fPBxS21LpNcaE9CCtPQ>
 <xmx:dOQparx40nfC4s2qC3z7Vj5MPgIB0odCsD22F2yAMiv9M2gQnKZr5w>
 <xmx:dOQpakx6B_itSjXthpXBOUlglub9iNeH2xgDu3acczrugJPgRtw5zw>
 <xmx:dOQpalYXNS4_6jRVgymiz9ICFR90RB31e7YsjML0DNH2mW_yeAQPaw>
 <xmx:deQpaniIZvejlQkfMlk-FvvXrsaDacW7WiaURvdEZ_24QgUZD8q3rMmT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:25:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH] power/amd_pstate: fix frequency matching for continuous
 scaling
Date: Thu, 11 Jun 2026 00:25:53 +0200
Message-ID: <P5PJT0VZRvmjicOy6zR-Ag@monjalon.net>
In-Reply-To: <20260328193419.106100-1-stephen@networkplumber.org>
References: <20260328193419.106100-1-stephen@networkplumber.org>
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

28/03/2026 20:34, Stephen Hemminger:
> The power_init_for_setting_freq() function fails on systems using the
> amd-pstate-epp driver because the current CPU frequency read from
> scaling_setspeed does not exactly match any of the synthesized
> frequency buckets. Unlike acpi_cpufreq which provides a discrete list
> of frequencies, amd-pstate operates with continuously variable
> frequencies, so an exact match will rarely succeed.
> 
> For example, on a Ryzen 9 7945HX the sysfs file reports 2797172
> which rounds to 2797000, but this value does not appear in the
> generated frequency table.
> 
> Replace the exact match lookup with a nearest-frequency search.
> 
[...]
> -	freq = strtoul(buf, NULL, POWER_CONVERT_TO_DECIMAL);
> +	errno = 0;
> +	freq = strtoul(buf, &endptr, POWER_CONVERT_TO_DECIMAL);
> +	if (errno != 0 || endptr == buf || freq == 0) {
> +		POWER_LOG(ERR, "Failed to parse frequency '%s' for lcore %u",
> +				buf, pi->lcore_id);
> +		goto err;
> +	}
>  
>  	/* convert the frequency to nearest 1000 value
>  	 * Ex: if freq=1396789 then freq_conv=1397000
>  	 * Ex: if freq=800030 then freq_conv=800000
>  	 */
> -	unsigned int freq_conv = 0;
> -	freq_conv = (freq + FREQ_ROUNDING_DELTA)
> -				/ ROUND_FREQ_TO_N_1000;
> +	freq_conv = (freq + FREQ_ROUNDING_DELTA) / ROUND_FREQ_TO_N_1000;
>  	freq_conv = freq_conv * ROUND_FREQ_TO_N_1000;
>  
> -	for (i = 0; i < pi->nb_freqs; i++) {
> -		if (freq_conv == pi->freqs[i]) {
> -			pi->curr_idx = i;
> -			pi->f = f;
> -			return 0;
> +	/* Find the nearest frequency in the table.
> +	 * With amd-pstate the CPU runs at continuously variable
> +	 * frequencies so the current frequency will not exactly
> +	 * match one of the synthesized frequency buckets.
> +	 */
> +	best_idx = 0;
> +	best_diff = abs_diff(freq_conv, pi->freqs[0]);
> +
> +	for (i = 1; i < pi->nb_freqs; i++) {
> +		diff = abs_diff(freq_conv, pi->freqs[i]);
> +		if (diff < best_diff) {
> +			best_diff = diff;
> +			best_idx = i;
>  		}
>  	}

GPT found this problem:

power_init_for_setting_freq() now assigns pi->curr_idx = best_idx
after finding the nearest synthesized frequency bucket.
However, set_freq_internal() skips the sysfs write
whenever idx == pi->curr_idx.

This means that if the current scaling_setspeed value is merely close
to a bucket but not equal to it, a later request to set that bucket
will return success without actually writing the requested frequency.
This can happen during init too: power_amd_pstate_cpufreq_init()
calls freq_max() after initialization, but if the current frequency
is nearest to the max bucket, freq_max() will be skipped even when
the actual sysfs value is not the synthesized max.
The nearest-bucket match should not be treated as an exact programmed
frequency, or the next explicit set to that bucket should be forced.


