Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4962C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 17:19:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A73484026C;
	Mon, 21 Jul 2025 19:19:53 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id B5FBD4021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 19:19:51 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 37CA614001C7;
 Mon, 21 Jul 2025 13:19:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 21 Jul 2025 13:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753118391;
 x=1753204791; bh=K2RtaWgM3xB6pQvRHwCd90T3Hi4KzdUlQcd7iiOUQF0=; b=
 u1Uw7tmx6i7XpQcQi+e0oG6kdaQGOI7BmzQmrX65Ub+NM5Ap7ekpU2SzPCmH2w0R
 HA0c/qjr8h6p0RRRF+Jvv7bVTMNLINRhdhowY6q9Tp6J4tR1qDjQM9RWvqFDloa/
 fY/5qKK82A8bY7RhzrY6qEYY8DWYWAxoOM00o3EI7VhQH+zq3pcpZUpL9eOCY7+Z
 H2kVIiIWsIkPnCslQM2KwfTwwWz4+IvB2JZSmVPnyhdBaFnvHRra8EnUoAPQ/BOO
 wWNdiWuqL4sksKj6cmrG5jaIhKbU7JW4Z/M3XsmaM0FFPS1j49D/vFmQFP+qXgPI
 Yf0WEqbG2UMIiIvuCGN7ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753118391; x=
 1753204791; bh=K2RtaWgM3xB6pQvRHwCd90T3Hi4KzdUlQcd7iiOUQF0=; b=F
 ce0X4seFPM8nmpoDuFLKeq6LutJRFZFN/WnLcnuVjHM4wQNA+rTneImlL+pt6p6i
 4FTWSC0r1p9PdY2KEcVWkPmVnmSH65FfC90i2SMb1idsELt5e81AcETpXZXxRZF3
 nlSsNzUZK7a9k86jM3o+6Gxa0DqPLPAfOAlXhro73GyjVAvzaJcu6J5oPHEPx/MC
 njI1ftDT/9tTiROlCzLy83PrUxEskqAGTIJLv/1+4LezEXRZbVjPpyh5KZd+7ynO
 4+lBmL2cGvj6pKq7ResxdVM0aJSe2qJENzeTIXXMJZk2ESkba0U26rkf7z5J8FRO
 AVhbuik03yStU3uwxCDLA==
X-ME-Sender: <xms:tnZ-aJvAOmw6UrOMiP2IKu-xl9VBpaBeroJKg2RvLtaNVDV6WrfEFQ>
 <xme:tnZ-aMH2h7JU3SdcZXSNqIuPY5QsOkKIWZSMBxld6hyS9eYgh5Qy4uEfWuTzIhImV
 rXh0_IpbX1ft9h2iw>
X-ME-Received: <xmr:tnZ-aMxtU7V8NJu8uEKzScCrqk7dd_DFlH-JLFP3AD0wHNX_WYGwgoBC7cA6oQ8w_m_HrkTTtiQlUreOzkTFdwlmcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdeiiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrrdgsohgttggrshhsihesghhmrg
 hilhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegs
 rhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:tnZ-aDgQuX21ywLXnlpPzBM2MBZzmu6gdGOb_jl25H_13deGhcpUBw>
 <xmx:tnZ-aHy7yDi20OiMIuRc3dyS1Ccc7_Uq1TbIUvoEb-AEu8MfLRGGFg>
 <xmx:tnZ-aGK3mk4kOvoaoISEZ599Zs82D3O1OaEkqxlvZHNwCQBwcAn_ww>
 <xmx:tnZ-aOShi40tgC8a0EUo64j2QSrb8YlXvpKORkTPBztRbrRz975NRQ>
 <xmx:t3Z-aIXMDxGVAh-mVsy2E6J5lVP3Er-F_7XBbLDCbrf1VCQNgIeBpFY9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 13:19:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: luca.boccassi@gmail.com
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] doc: install guides and api docs to different directories
Date: Mon, 21 Jul 2025 19:19:49 +0200
Message-ID: <2923338.Y6S9NjorxK@thomas>
In-Reply-To: <Z3uwxOEEWlSxfMPK@bricha3-mobl1.ger.corp.intel.com>
References: <20241223153846.230648-1-luca.boccassi@gmail.com>
 <Z3uwxOEEWlSxfMPK@bricha3-mobl1.ger.corp.intel.com>
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

06/01/2025 11:30, Bruce Richardson:
> On Mon, Dec 23, 2024 at 03:38:40PM +0000, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <bluca@debian.org>
> > 
> > Otherwise they both get installed to /usr/share/doc/dpdk/html/ and overwrite
> > each other's files
> > 
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


