Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3AAC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 00:17:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52809402A7;
	Sun, 12 Jul 2026 02:17:08 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id C1AB84026F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 02:17:06 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 11399EC00B3;
 Sat, 11 Jul 2026 20:17:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Sat, 11 Jul 2026 20:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783815426;
 x=1783901826; bh=RcyUoePQrzkoRxe/QAXn3ICUa/t9zuhYYaOSYKrnH5g=; b=
 HAEC+xPCn4xJfcXdFnuclZV41dxbin0de5EuEkHbA+GeIBaE8m2wFhW5biXdWkrA
 5frXxFejtrQRnQzH7nHaNwSfJEkk/qrcBB9x7TiZpnlitq0eYjedGaYrv3aB8KBA
 XbP9ChSXdUfJO9dpo948q/yJu6u9aouRA+3nem24Gbu2XZMszCvfe7lqQKb8PhZM
 csqbyGul0EADs4wChRJ4PwYD+wSiW/6TyjhQQyclvpHsGYbvQKjZM0l6N5hruK8D
 aJ0EObB9M8Zo7gLaJ2oYzvLufbzhBZg/FmW/nBpPdR7zs0HrkmqtNHIYAmqFHAhN
 7FeQ5W9oO2qOEMJNcmu3CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783815426; x=
 1783901826; bh=RcyUoePQrzkoRxe/QAXn3ICUa/t9zuhYYaOSYKrnH5g=; b=O
 D0Xr6aKqJzhdlM/950NCoMxu5xvdzkrWLP/pmawxS0T1WMkDFXkX2fFfZN1VtjAj
 HPOGAJA6WKVH4A2lc0U7UGB43I/44OclUu2BFrsshcekdZNulvSx72DrzClNlIur
 bZNUlbJZ7I3u1Rf+YNvPHdqJ+w+llZkho3R1PdWzdRd+Cdm0xktJUvt7KzFaZ/zS
 EQrfQvTNnD6kVOOD1+sDpIS2No94INLNxxrJvQGM4Uqy3VgzTE0D/QGtAPg8nJOv
 7vShB7EEcBGCsXn16ehZ/ru1VHYtR1XlI92isQwCS8OMfN6kjRserDaTk1wo6qLb
 M1SgcaszVeWW0tl2cG/ew==
X-ME-Sender: <xms:Ad1SahhehBYnN0r9yYfpKVib6ygEtWb_OFN7U6ATX5Q_gjS4_589Cg>
 <xme:Ad1SamIhlxvXZT224mmhsxPWV83ln6ZkOWTjXygnMDU_hrSw9ZjRqnnQWhXTtJ4dO
 TBRepbBO849apoqMR6nlmoavmrlW-oPHi7XkxL3Y3LlMAiKbEJ9kg>
X-ME-Received: <xmr:Ad1SapBMgrcy3XTgJQEkXSZi7dw6mv2d6aTRFqclojakEeMCNc7P86vlJSvffm-0D6iC34epRrgGYG1GVQ>
X-ME-Proxy-Cause: dmFkZTEJm23+AtCiArqySbCLq53HWhW/lSlifpmTSuteKP9DVnITYAzO8hHb97CM8EG/li
 5ZgB72/xXbWoW/WkKO1/EFwZbK26A47TMWVpxjq4c/27FMfOlT03bVi6r76JwfwIOxnbaK
 N/XU7bw/sNMio+FienLVfOgXSk4icxsIfMW5F2Vhl8jF8u2tA1qiNeTEbiETPyoF0tBdfG
 iX7NJmKlEbMnOp6+x5ZDFV46HnUUwuEINslZDdmmq7z9g8muoOcq1z+4wvmlTXgWNNiEg1
 nuAEsgBQpyn/+38bhrb7POuP3Fgpd8Z6maULw4JsKSwvkIYE410nLuBDop9+DP9h251ok+
 Q2unCKV2f6XdeGXEdBtRGCPokgzP6lvpJvemWw84eSo3zE/GpunSzifwUE1KCZH2mAom8F
 ngUopue0uFS3RRZUz4dst+ZuFOsz/WiQsjbJuIaBLTPXxAdz9Jyp0n+ogTOdEugvtjQTms
 bDwk/nNgemmhgUc7YtX/YkzFWeIHdtOoX/CnIk+YDon6YEDx8pOmROhAs3N8kKXcVN5KO0
 hBREhjooj9z77UG2Aa7vH8RIL6eLHd+TakKNnNViZWgbN9exH97iKipQ9cZOfCw7XvmwHB
 7zFzerV+Y9DBq6oo86L8dU9zmmUs5mttjbX2OY1Oy+zgVt6Xpp8iP41DSJew
X-ME-Proxy: <xmx:Ad1Saui5MgveFWYw0WaFQL1g042blnuHzEy7I5kKwQHTV0sktVkAig>
 <xmx:Ad1SapmlaVd9h-TcBa1BLMfqOFGdBqXgzb931bA0OwX_nCs0-WvD7w>
 <xmx:Ad1SaioG71LSBC-DBIO0YGpVqazd7QKpv7WWD_3ZlatrsmMFzA_kzg>
 <xmx:Ad1SaqGRSNfgGdJgpSUKT3FjzONgCOj529Ix9CVM6WKp-DsxGdiX_g>
 <xmx:At1SaojsVV-B7oT_YhxtY2ovkCJKS_NCUSSlQanl12CNXdrb3bvzEwd9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 20:17:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 sivaprasad.tummala@amd.com
Subject: Re: [PATCH v3 0/6] examples: remove MAX_TX_QUEUE_PER_PORT
Date: Sun, 12 Jul 2026 02:17:02 +0200
Message-ID: <t6KcvAQNSxmP0tIP2RlKqA@monjalon.net>
In-Reply-To: <aj4o9IOCeg7qWiNs@bricha3-mobl1.ger.corp.intel.com>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <20260625174908.278408-1-stephen@networkplumber.org>
 <aj4o9IOCeg7qWiNs@bricha3-mobl1.ger.corp.intel.com>
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

26/06/2026 09:23, Bruce Richardson:
> On Thu, Jun 25, 2026 at 10:46:50AM -0700, Stephen Hemminger wrote:
> > This is an old set of patches that removes the use of MAX_TX_QUEUE_PER_PORT
> > in all the examples.
> > 
> > Sivaprasad Tummala (5):
> >   examples/l3fwd-graph: remove redundant Tx queue limit
> >   examples/l3fwd: remove redundant Tx queue limit
> >   examples/ip_fragmentation: remove redundant Tx queue limit
> >   examples/ip_reassembly: remove redundant Tx queue limit
> >   examples/ipv4_multicast: remove redundant Tx queue limit
> > 
> > Stephen Hemminger (1):
> >   examples: remove unused define
> > 
> Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



