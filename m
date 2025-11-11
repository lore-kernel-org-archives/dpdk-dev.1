Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E7CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 17:44:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C689E40280;
	Tue, 11 Nov 2025 18:44:14 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id E9C964026D;
 Tue, 11 Nov 2025 18:44:12 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 230667A0182;
 Tue, 11 Nov 2025 12:44:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Nov 2025 12:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762883051;
 x=1762969451; bh=FhkmhAPKwQ12w+L8KmsMZw3iwNp/Uf5njeons3k+/9o=; b=
 MCcrajwVFBwPbvSYZG1eEUIbo0NbLSlLpINJhRUXAx2KrXjxAy2DfE7/2tL4QObj
 v1pGZwa5EPsDBw7gMdKhuxkVFoQegaZOd2cmcjf63WvMCrNmf+OjCph5/ypNKG1Z
 Ve6eS6bLDHuQtaj92ELiEH/xEBEsBORFpvUWHYPJyT/hYC+VsRMpjndNST+lHspV
 lo1lX/m3xDAAzuAUHHqTQW5R5WyPkOx3Drd5V6qdbzqusXPtwUyBPOvNXymftp7Z
 U/9GD9p2oCQnv8tFgtL7RC6/E/Sbr4Rne0hDvMzE1Sl9eyziLPdgtASbWdU4SGdY
 yiPIOdfAL+jk36T25Rt4Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762883051; x=
 1762969451; bh=FhkmhAPKwQ12w+L8KmsMZw3iwNp/Uf5njeons3k+/9o=; b=o
 Vxbz2hEZXUjeiqFtAX+TrrZWtx3bx/UXHf2Ugl+KZDSHzHPKA1UHdNW+RfL2BBM6
 eOL4r/H7uqJMETrDBqjhkBh3VhIhlIO1cujnHAg1hUF6ULjcOpcTmoJVHSy56Fsx
 bh7G85CAjV6VrUtoaJpwpTm12z/BBOdjb+04FL+Eqw46FfpHfW/UNn9egjT03wIs
 TA5KxPF784RMx29K9n0PLP2jkKNnkBJMJE+uXGAPzn9xw6AMWtA0mwRNTnEvoW4I
 D0v6hIWXNnoPjN46jkEVXKBOSMpT5F31AbvK4u2xMRjVYovZtS8M3kMDyds3vQr3
 kxSxptXZ3svtB+r1NBEhQ==
X-ME-Sender: <xms:63UTadDsn9E4xXq1M09fop_34fpLoOPXrzKztakaLhRssRg2MyjyNw>
 <xme:63UTabo1LKo-PpFfXvTVziHOBiwAxpwXpEwrmB9oJwOj1YgjZBbI3fnjoFtrmT0Em
 WkyQ5tB7yZkoWO3TB6Xfib_J4Rx9qYQG2nchoN6dct_QytAMXafGA>
X-ME-Received: <xmr:63UTaQgGY26E1cpYOD4Dq1QzxkmEllKeZXl-7ZCPLmkdJYvZDtSKIhuQ6jZkBCZZTtvb5NTJDskj_Gx5PUC5rInNww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddukedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdr
 rhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtrggslhgvse
 guphgukhdrohhrgh
X-ME-Proxy: <xmx:63UTaQCCI9q59p42UKR4jJdts1BxZSTgvxdI_YoN82efeyjaFFeoJg>
 <xmx:63UTadFn1A1xsoFh81OSiHQD6XK0PMDiCq7BaUhOn4q1xSogfLevGA>
 <xmx:63UTaQIIgoTFRcO4EZUbutyYlFG4CHrUxap3_BcDPov3R4uEGVlLsw>
 <xmx:63UTaZlqqAnw0kOH06JeKDjMi8dFv4oc3kBZxNenXs6MD5khsUv47w>
 <xmx:63UTac_ooXyExYGEspItlYhCGsVZ6a421sf7-9B1MIJtXrOjHaMLZRz0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 12:44:10 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: Re: [PATCH dpdk] telemetry-exporter: listen on loopback by default
Date: Tue, 11 Nov 2025 18:44:09 +0100
Message-ID: <7140745.6TB3vktIsb@thomas>
In-Reply-To: <20250127115143.585207-2-rjarry@redhat.com>
References: <20250127115143.585207-2-rjarry@redhat.com>
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

27/01/2025 12:51, Robin Jarry:
> Fix the following warning reported by Coverity:
> 
> Defect type: SIGMA.insecure_network_bind:
> > dpdk-stable-24.11.1/usertools/dpdk-telemetry-exporter.py:278:
> > Sigma main event: The HTTP server binds to all network interfaces by
> > setting the IP address to "", `0.0.0.0`, `::`, or `::0`.
> > This may expose the server to unintended traffic.
> 
> Avoid listening to all interfaces by default to avoid exposing private
> information unwillingly.
> 
> Unrelated: The Python stdlib TCP server listens on IPv4 only by default.
> Changing this requires creating a subclass that overrides address_family
> to socket.AF_INET6.
> 
> Fixes: d94ebd627a86 ("usertools: add telemetry exporter")
> Cc: stable@dpdk.org
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Applied, thanks.



