Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC3BCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 21:34:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6D5C40264;
	Sun, 17 May 2026 23:34:49 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id A6B1440261;
 Sun, 17 May 2026 23:34:48 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1951014000CC;
 Sun, 17 May 2026 17:34:48 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-05.internal (MEProxy); Sun, 17 May 2026 17:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779053688;
 x=1779140088; bh=8+utjMQZgNGx6itqoWBXcTBxkB1CJ5fWPuZ6rSAFB58=; b=
 ZeE7IzcQKMv3aB9NWSUUMCL3tUyARFtTWsIdpirvCFf4gVBXzw/zOb18aRBdM44l
 L9urjzHKqT1wUOiZC2Zdd/0I8CEZIBfyB/GewaT5mje9dmT2bhFTvMw/yD+ZHaZn
 KU0vsALMkTnnFHIg90cP2T4AEFBXnZtVIcoY4xzLbvqJWozIdcGGPWrPJJ0gi930
 VuvG9ZETXHcw4f2gCfHj3QnOIVJt6EWoegVRbpq8lbOPkvqVef8i4KJUVD/NtYWm
 bsFejohdvU8n8ytsQhYxPA83kWiBaCHVqop5xnhadlsf7mLX50iSn31oNlAiXU7h
 70Fm+RFlSbAKmSKSqmRmIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779053688; x=
 1779140088; bh=8+utjMQZgNGx6itqoWBXcTBxkB1CJ5fWPuZ6rSAFB58=; b=Z
 XdjdCe8WdYb01y13TYuCiXcywy+Y0NcbVHAggQ6s4pNNClBZDOMYGacMtAPqOTHY
 pGLhkSiLP5+3KQpsZv/sPk3kQH+ND46qV8QAHs/kfz/IvB0JNGmv68+9XhBiVxTW
 D2MkWXc7PSzqsbZPTqsuX44QpPrkJ7+XtNz+1MU39B+LpFyDJ/H6CcvJ/bDLAAFM
 4imlion1OuHXqCjVjUJv1v5GZ3+q7N//30VrBzIZPNfY5cRuNpjLAFD56+4vVNne
 /BCTNbRLlvb2xjTINAqlXEQa6LNXCaO37jBYPM2H+IpsAVdTH0AApUqFFFQlyplQ
 YiY+2vmyfxSVloQIlbLsA==
X-ME-Sender: <xms:dzQKah1ipuXg9Q3AR9EVePeEsc-J0wXROZGQKVB1WRTly-MVU2hJpQ>
 <xme:dzQKai6oSLip10izcnGoymFOE_Zq5apgqrfE6ORrF58saBUGez5_5eBsjmJvjCGii
 Jx_39isHjaWcDKaA2ID8XPuylinsdzS_2HiDoW_uCLpaOjWmicWOi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejtdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvfhhohhm
 rghsucfoohhnjhgrlhhonhdfuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepgeetffdvvdffveevhfffteegfeeugfegvdfggeeuffffffel
 udekvdeviedttedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohep
 hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpd
 hrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggv
 rdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehhvghmrghnth
 drrghgrhgrfigrlhesnhigphdrtghomhdprhgtphhtthhopegurghvihgurdhmrghrtghh
 rghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:dzQKajjPom6gagP-LSQobUrmrJHvf934bhDj01XeVAXbOhcPwj7ZMA>
 <xmx:dzQKam5xSxS_pj741Qhobvq1Tmx_gIsTid_xuIxOPGYivHLXHrksTQ>
 <xmx:dzQKarayggQaLN0aS39MWlljWwUe1Nig3yOgxjkfeOkfp50NUJIQ7A>
 <xmx:dzQKar7FnnEJdAmKTwfmoxnQmzidgU1-15ohZ2e3Xgdg5xKJe83gIw>
 <xmx:eDQKapw5Zrttd7fjXbxptYp3cz7JFnmYs66ahKmjt9VXoAbC5ojIk2ty>
Feedback-ID: i47234305:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id C078F2400098; Sun, 17 May 2026 17:34:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Sun, 17 May 2026 23:34:26 +0200
From: "Thomas Monjalon" <thomas@monjalon.net>
To: "David Marchand" <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 "Richardson, Bruce" <bruce.richardson@intel.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>
Message-Id: <a32f8e93-b2ff-4088-8498-f549e2ce2e29@app.fastmail.com>
In-Reply-To: <CAJFAV8yAP34iRGiGKx0+Ls6_FpSa0EubP3KiDrUEU0fY-tp0FQ@mail.gmail.com>
References: <20260429130935.3681177-1-thomas@monjalon.net>
 <CAJFAV8yAP34iRGiGKx0+Ls6_FpSa0EubP3KiDrUEU0fY-tp0FQ@mail.gmail.com>
Subject: Re: [PATCH] devtools: fix SPDX tag check
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

>> If a file has no SPDX tag and is not filtered out by no_license_list,
>> there will be an error when using its path containing a slash
>> in the sed command delimited with slashes.
>>
>> It is fixed by using the pipe character as sed command delimiter.
>>
>> Fixes: b99a3b8aa989 ("license: standardize SPDX tag")
>> Cc: stable@dpdk.org
>>
>> Reported-by: David Marchand <david.marchand@redhat.com>
>> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
>
> Acked-by: David Marchand <david.marchand@redhat.com>

Applied
