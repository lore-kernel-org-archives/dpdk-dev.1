Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09D4C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 19:45:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FDAC402A7;
	Sun, 12 Jul 2026 21:45:42 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 46E4E4013F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 21:45:41 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8332714000F9;
 Sun, 12 Jul 2026 15:45:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 12 Jul 2026 15:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783885540;
 x=1783971940; bh=y3MICI/KJFyej7mg9P3oiu//et+k3DmeWxqhEI1so5g=; b=
 juPu2e9sDX99ladH4SdW73U0JJ6WhWMA9osOcMk65jhiEJe7a8APk4fqhyh0yE4k
 PeKwgsjXxsCQORufJS119JexwcKadBt5eIrG/qLntdS7/3gdo5NM7WZ8nMXff6gt
 +LiDcYbFbNW3hg2CLE/PdAcbet7Sww/dtJ5ZHUVEPJNTiEjlXs8qYoEHOgcoY28E
 dRmM+RQhuhQG6++rP7pwyIXCTTfQlmPfDentx7FmOm3+H8sGqT4i7uvRXSG5NzrV
 GN6mtsPu6PRdzG9/g/mmwzO4SEuPSfClmojKBm6KsUWziUpEwY2fLOyNk3XG5CKr
 acLPwj0vO6fFHYGnNZnOhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783885540; x=
 1783971940; bh=y3MICI/KJFyej7mg9P3oiu//et+k3DmeWxqhEI1so5g=; b=J
 wspt0A2Mmt6bjjtFw4G6DHQn3a5rgRfMpt7zbVZpEzqj64D2xumwFWxDUWd1hdLC
 4P3FuCeVo16AU+DLYH/s1qu9039ybfY24qcXS/FuEYMFugphHhl9X2zaCS+kYWPu
 fQvNArgLkLnUFc/ZhzlQDeRPLsglwjQHZzJ6dknYsULhkkHP84Oh+ZbEuZFuJvHG
 HPVUysClFL4ZuFkmV5uJM9SnrHoqRzAy2ngfc0Rc3FuYyprjgWOy2oFMMbzX4Jav
 6H0c0XXqt3o+3fiBDjDwuX6pEHQOcIVBpUlryYfxQ8Roxyb6whtm4F4AwnAWEQBn
 yytjiLNk0mqxlfSvY/n5A==
X-ME-Sender: <xms:4-5TaooNk8YV0-I0wv35KyfyuUPUH7V2SM2XKORfA_zHObyur3YzzA>
 <xme:4-5Tai-rlm8OL677t9Z9lkU6vLMRPweWkqjJtwoMvsq_OoG8eXxdefLt0Q97hzBi7
 H3qtMvt8Ck4G01WSOqdDJCPxM-ZV50rjKGk97gHULY0lo83Bjs85A>
X-ME-Received: <xmr:4-5TasXP200ito6NOAAfiwiKW_YH0wsZxnbenD2ESuN9w3-Qw7Z_rx7UWdok7TYuNdBrJXiIUG5OGRX4xP_EbG0>
X-ME-Proxy-Cause: dmFkZTGxTVSQGRCNXjPjcgjrT6OP31nMEKNG9QiMKpdeXlcYgB61dQu5rTMEZBjiwNB5MH
 +DJrs7tXI6siQqlkrooSiSw+kZwtIM9bV6muMyi+ECFoxOJHzmHQn+Qz79fq2uVzHVWb6o
 xfiUE0vUHP6FVCcedQUN4+uiUjXQ1j55+mlxBSvV1yr3O5eiFenncIUE4EpknMYU7nSrol
 vXOmOD5IHOH0j9JqBKS1nALjPEysRivcSwbBeBtyz8x2pA0fVUgAdA/9yzrVphgyu1wBDl
 T/FzQUXXabCgPo20w7yOJQvi4GAH4iLPXHt0Ckbqbb9VJxJSl8OmCQKqoAHpZhqYXMKlDu
 msebVH++jieSCMVtyTOGICAd9cPJbG2yiotJSx8Wxbz2maCdAS60BTFo53wHSvUjffPgF8
 N/gxWT8A8ATsaOFceCXyg3CQaFFRs4b12F/33nwdDhf2EXlUyHTljVcMlzSQXWRjDXGA0R
 opw/XmP6FjG+EhcXVoHYYAMJ4ktXb7Bg7hhbPGwR56fO1iVdG3wB4tWhgc7FGl0qkDSUqV
 QVB5SEc0IEamNfYCXlzwHnNGX/a1VAoUTpHdwowOHmWiouGAqT6LQwaehvrMoxUi67o4N2
 9PgBMbZkZ8AZbQtWyjhW7C3hLz2L7ZAh06zbo3rqAwyp8gE4fVdUhHImIyjA
X-ME-Proxy: <xmx:4-5TaoBssLRvkx9-t7YaWPgdGSve62aliCZ6NuPF_EIrapdKy8TwHg>
 <xmx:4-5Tatw6F6u4ylfZIq9FgOt7_EBA8dB7_NIMm04JvRh6DPZiZnVKkQ>
 <xmx:4-5TalA7YKsHscEGAkWbMPTagACrfcMj_po3D14qnCQmWVUp3109Mg>
 <xmx:4-5TaqacZOVz3QUxN4TIbiVxMJjJ7nLAGLDoi6y4nrmgD3UzxSrmeQ>
 <xmx:5O5TavUGC0kGRTKISUbvZLZ5S9zapR3gSvH5VPFubsB8QfSgwVy5Peg5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 15:45:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH] doc: update warnings about primary/secondary process
Date: Sun, 12 Jul 2026 21:45:18 +0200
Message-ID: <o9i2j9VFQVi9CBogtxY7JQ@monjalon.net>
In-Reply-To: <20260408152808.201257-1-stephen@networkplumber.org>
References: <20260408152808.201257-1-stephen@networkplumber.org>
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

08/04/2026 17:28, Stephen Hemminger:
> The existing documentation about primary/secondary requirements
> is not strong enough; make it clear what the requirements are.
> This may be obvious already to developers but not users.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.


