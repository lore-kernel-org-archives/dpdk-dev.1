Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB3C44520
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 13:29:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90C2240A6C;
	Fri, 17 Jul 2026 15:29:57 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 83516406B4
 for <dev@dpdk.org>; Fri, 17 Jul 2026 15:29:56 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 02A581400078;
 Fri, 17 Jul 2026 09:29:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 09:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784294995;
 x=1784381395; bh=Ae/IF2KYnWc55CYyHMeD8K9gx/g7dpp1h48n5F2xbUo=; b=
 VlBdnYt/uTvk8ZzBCl4XX3+k/P82GT5SoJbQiWjazQVmngOmx/ujGtL6jbe4f0qF
 g/yipHdb1IE/8CSyfDdGV/f9rXFXRp+P9/YDb1rmeS/essaYqjOPmyn4YHDUtw2K
 q2VEPTtQj3cgFLe5s8Pijs5lY1FRRkRifank5U+GbIvkFEz80GkEqVCdVITl47n0
 kyhOwJnP+PB+U0TBthZGWF36oAt7GXRGPZ35veV3rWUZwXb7xf5QJ4NJJwUzQua4
 Gs6lEWTLVJU/ULd0SYcLU7N0+3dWm0h71HXBua1u4SKGb1zDe0j2t9KheYghplil
 jhnKgWcHVnti+U2ThTuhFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784294995; x=
 1784381395; bh=Ae/IF2KYnWc55CYyHMeD8K9gx/g7dpp1h48n5F2xbUo=; b=q
 JorBnZ4L/ylwrzRqepqXop2AMeMa0us7RmCj9O8MNp9OB242f/aq3rL/sgkmf3tN
 40qiR0WUPFI56LkLde008ABcnJYGSV5NUDyRkWH9TJLRDI1rWDjls6ZC1ptXHyWG
 BVTCZyMuogEoW7+AUymabIIRCCK71A+aJSjQf06UWW0KxQK5bBhvOvX/DDm2dPfH
 BkxAykXuvXO7gaRDlKZaZceQMmtnlJvR7DBuGweBquD/E5N5P1zpkKTLPLz3qVf4
 O2m0IVsTWgrEX2dQC9WRRzhufKVWV5ZDGCN//Uy8UnHlCfND0yrWxN7XLJIiTS4w
 FpoQfl68KnoidEx4fdNXw==
X-ME-Sender: <xms:Uy5aah9u0O3E5VLNLZp8RPKt5O1m4xYZiI8c7HzdgQvhP9VvlIm4RQ>
 <xme:Uy5aaiCq7ayN6yyAwzkU8FqK3hcXFVKbspYmECDRBYtWlmQQvmRfrdrc-VSc0cPW0
 siuTTi3Ksllws_IotrrJZOoRojPcqoaJfQ29uRbSzEG_3DW8DAS>
X-ME-Received: <xmr:Uy5aahw5icwGjPgq5TP-MF-0yqBD1jYiF-F2Du5IuQd21vDODwljBNXRv8axskseWZcDRs7gbyVh9sTavg>
X-ME-Proxy-Cause: dmFkZTESlQaFNs7M8Ycgapgyf4VI4PDm1jyJnVOdgFR3qespEu5pFP6CUxVqr0RohysKDB
 h342jQriwU9fHZ6v1XQP18W8BubR8MDMrgtdJW2R3cYTnkfc1NKlFFasZ7KbcsACrVVzSB
 qQnoPoP6RRbwiWUN+B1dW7NZXycyYUFVzTeT+eTH6dPCNOY/CkESj9YZY1jiXeVCvK6+88
 bwWj5hZiG6kzPmjah7DDgh+vyOzRf4Pm7wWqjSAcxM9C0km8XNVCS1EJxoIiCkqrO+3bkY
 idUOsg8eKxLhMzSpEDpsp0awUdMYSL7OiERLXDFedUEYEwY6bIAlEWoEpAdo4Gp86mQlor
 4HcIP4NaN7T+8aJzemqrffMglbnUhVENdZ0myN7m2+nEkyzmFf6m4gf3n2WWBVm0EcP3vr
 4kA+az1OFcP4FWueYxUHZnRzl4UMvgWtqh6sS98WuqJDN6q1T3oLnLbbnvOcvfUrPEOw+n
 28dLQ1ZFwdog+Xdv84YfYYnQXcJqfNdWgzwbb/L/Q+yK1YLq8fqJ5mD1sIZa41GNcijkr7
 f3ZJqEl3O+5rMC06dG4A8WZ/z/hVrScoL51VwarW5YHAyZqqw1g+ehMcSTvsDZlyTorGQl
 A/Z7kUibRs+DelfRyFxlGREtnDW3dkrmDeSoAzsrxS9RPfs8TSdDQ4dHRqqg
X-ME-Proxy: <xmx:Uy5aanQYICbtn_7TkRxrZHlv8JLphPH5aoeSje1FkbVVgfnoZ5pKIw>
 <xmx:Uy5aao-X22jfk2SmqExEnG98iagZohMAXGdmMo7qa1U0XApWrt310A>
 <xmx:Uy5aaupKWNHutQHVuccfh5A6Uf_1PBzGkTkqbb3DG_cJe3Mp4hUV0Q>
 <xmx:Uy5aalmfZFv0rzJCLlP7CPw37tug7FxrPwmEpwWwWpi5S8ndn9BB1Q>
 <xmx:Uy5aaqKA8JOrSy5A5lgh3hHhHtZ2LEieBkiGC_q2oDPHc1gdb0ivYIUr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 09:29:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Arin Kharkar <arinkharkar@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] Updated skeleton example code to better emit error
Date: Fri, 17 Jul 2026 15:29:52 +0200
Message-ID: <XTRKMiZcSAmd4Wq2exFNLQ@monjalon.net>
In-Reply-To: <20260512192834.130651-1-arinkharkar@gmail.com>
References: <20260512192834.130651-1-arinkharkar@gmail.com>
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

12/05/2026 21:28, Arin Kharkar:
> Previously, the program would check if the number of ports is even and if not, would exit with an error stating "the number of ports must be even". To provide more information, the program now states how many ports were found. This is especially helpful if 0 ports were found, as it explicitly states DPDK wasn't able to find any ports, rather than making the user troubleshoot this.
> ---
>  examples/skeleton/basicfwd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/examples/skeleton/basicfwd.c b/examples/skeleton/basicfwd.c
> index 133293cf15..381e4d4273 100644
> --- a/examples/skeleton/basicfwd.c
> +++ b/examples/skeleton/basicfwd.c
> @@ -188,11 +188,9 @@ main(int argc, char *argv[])
>  	/* Check that there is an even number of ports to send/receive on. */
>  	nb_ports = rte_eth_dev_count_avail();
>  	if (nb_ports < 2 || (nb_ports & 1))
> -		rte_exit(EXIT_FAILURE, "Error: number of ports must be even\n");
> +		rte_exit(EXIT_FAILURE, "Error: number of ports must be even, found %u ports\n", nb_ports);
>  
> -	/* Creates a new mempool in memory to hold the mbufs. */
> -
> -	/* Allocates mempool to hold the mbufs. 8< */
> +	/* Creates and allocates a mempool to hold the mbufs. 8< */

Changing this comment requires changing the doc referencing it.

I've made this change, added your signoff and other details,
and applied, thanks.



