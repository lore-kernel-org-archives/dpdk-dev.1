Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25470CD98C5
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 23:28:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 442F142E8B;
	Thu, 11 Jun 2026 01:28:39 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id D631C40298
 for <dev@dpdk.org>; Thu, 11 Jun 2026 01:28:37 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 83BB0140008F;
 Wed, 10 Jun 2026 19:28:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 19:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781134117;
 x=1781220517; bh=nLD2lekj4kR9J6GhwKF8aAE/isC7ojzyQjum77PWOiI=; b=
 qmtLP9r/CvD4N50RAjYmaF/95c+7AvlYEZiWp2/TSNqla4+ewrXlm3gfLx2Cbnhs
 T9uM7mMek/cguosNdQ75ac1QFrrtQ6ry3WH8/SZfR95Q/0vU15udff/pvlPldo1m
 Btq4NDaOaKdIs/f/kgy7mzAdYS1hqdJe8AOCBP+m7E3o0P3fpq9YBWiYtrkgwl7J
 sHxubcmT/gzpQzkN9bfdV95wU/ypKGsPMHaCQUeMJD6TTJvp7mdvIkDEJsX4Gduf
 hEHHDqK7iTpZS6OW298OmeRsm6wnKdxPb1I25R8kRXSEwpiW/lJ9EkW1NBRPVqs6
 B+iaaxfbHOo8oRdO5OPtFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781134117; x=
 1781220517; bh=nLD2lekj4kR9J6GhwKF8aAE/isC7ojzyQjum77PWOiI=; b=g
 EpP6XQ0jAqZAsX/03Xj92LWOXojUslBllnxZEbC/6Po59MYs5Sm2NCiLaS24DoU7
 o6lDbpJTgqhfF29r+ailb8h2NelFE/JQ/0tWy2YdoFM42QI/TfxrHsb/KIAGGYsy
 Y8xml5oN+BiKS6CV+WwwDbXV2/lTWme7cTYuENgbqbbjjLfL2NQ7Jk227wbvS6MD
 aKy6gMgo1MYOxbVasR+9rfnGV3DGaK06/fmDHslsu62axHpQKcxrapx5Cv0nkFtP
 QdXtd7j9roS9ScF09xhDG4vGrWE76ICE/z/Qjc713FmSB/eEXjFr3DXsntzgCPdZ
 pO/ep51+0aQaYnQGawkVQ==
X-ME-Sender: <xms:JPMpashyavaJuSejbCgjU1aUOer76grpZ3mKByRNfw7puYrXyj3wfg>
 <xme:JPMpahCNiq-Sz6fuxc-QNybeQUK3C_yIU-IpVs9u0mAiDmAh9wEG2eKw8JUIIi3yN
 V6TVJ6d8Ai8f8b3jpYl3gsnKQRkSH4OqDwJBeDp5eJxleLrAvblFs0>
X-ME-Received: <xmr:JPMpamTAPabIkOjcV4s303pXcib00p5T8RQ1lnBTdMFrNPkXGvr8uf9LOfnEpHfVer9yX4UuDKAA5kZf2L8jrmnlog>
X-ME-Proxy-Cause: dmFkZTGn3mrOvuaJCPHvorijMZ8d5KY7lgWjcVip+vYLwcTKHEK63D2T4nMuCSAYhaMI8q
 EuCOzpFnlEaZq7XuWiYsMYdTlMaj8IfbkNMb5dc7mz8p5doaBwE7fQWnQRpxFQv8B/35nr
 Pzw3KLdltO/mg5SRgW37ae9l12QjsOcIHQV8d8YTp19mwkFy+NSFAhpn3/YyZ2hcvxAjER
 rCSjzmYFo7OXeXyswUpSAXV2x2+N6cUuZBGwJq6Rqyo5gSatn/wd8eYUJBsHcTNS1CJ/IF
 IrRhzsCujk/cSyD5sz6RiLNs4mhHEtObNetH+YS6CqrWwCku7N7+6PG3y6nbxEwndDcVab
 z+itIpcDs3N6rqVlLVyooIiwzWY9gqnEuFnj/bDZg2oeNkaMA9LxqtlAYbi/79Sw3kBuJp
 Er9TDC9lHvKf8rOieVcP177XI3bqJJlYk1eQUGHch8jX0myTaUyg1bp3EV9VOu1CpgHedC
 VDR4smELxBzo55F0uSDBFO+DYXrqs7u2MMHyYniyNbwy9lKRTdH84RbiXzuhtVbSWuxuVH
 FIHz9mDK0Ly0gbmonQGSTi7bvMQZWoAiq5Kf+PqNi6p7CWyJ/lAqg5OvgUqc4RLucKEnho
 IgR1/lzoijJqtzZimqioVIqP4h+sRv+0cfpPeZLBQWIushQiNbkaoTCfYFjw
X-ME-Proxy: <xmx:JPMpauWiCIpWX_P8sMvgNkl7dL_9dQNriP-GV_CLDeRc-fjKT6j-ig>
 <xmx:JPMpanfuQNANuQIASby4jMMadfJ7fHG3fVsz0I739nHL0eBfaiqDUw>
 <xmx:JPMpaiIoJRfU35DxVwx0GMdiVI6BAZD2vsWfm1OmSSSH7vKgKE0BLg>
 <xmx:JPMpakzSuDkpoYlN3ch8E1AnqUF1dAJhWhxA5cMrMe5P2fA_2tHYiQ>
 <xmx:JfMpaqlw1Js3v6tfusdoUhfV6qMkiTR-yUb3071MpTcaSv5ua2Fdu3hE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 19:28:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com, dev@dpdk.org,
 stephen@networkplumber.org, fengchengwen@huawei.com, yangxingui@huawei.com,
 zhanjie9@hisilicon.com, lihuisong@huawei.com
Subject: Re: [PATCH v3 01/10] eal: add interface to check if lcore is EAL
 managed
Date: Thu, 11 Jun 2026 01:28:34 +0200
Message-ID: <vMlZoeDqTD6UrHS2wuWBKw@monjalon.net>
In-Reply-To: <20260522041110.2023062-2-lihuisong@huawei.com>
References: <20260522041110.2023062-1-lihuisong@huawei.com>
 <20260522041110.2023062-2-lihuisong@huawei.com>
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

22/05/2026 06:11, Huisong Li:
> Add a new helper function rte_lcore_is_eal_managed() to determine
> if a logical core is managed by EAL.
> 
> This interface returns true if the lcore role is either ROLE_RTE
> (standard worker/main cores) or ROLE_SERVICE (service cores).
[...]
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_lcore_is_eal_managed, 26.07)
> +int rte_lcore_is_eal_managed(unsigned int lcore_id)
> +{
> +	struct rte_config *cfg = rte_eal_get_configuration();
> +
> +	if (lcore_id >= RTE_MAX_LCORE)
> +		return 0;
> +	return cfg->lcore_role[lcore_id] == ROLE_RTE ||
> +		cfg->lcore_role[lcore_id] == ROLE_SERVICE;
> +}

I'm not sure about adding this function in the API.
We already have rte_eal_lcore_role()
and I feel having this explicit ROLE_RTE || ROLE_SERVICE
in the code where needed may be less confusing.

Note: we should prefix these constants with RTE_LCORE_


