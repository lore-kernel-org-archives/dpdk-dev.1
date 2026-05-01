Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61FBFF8864
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 05:52:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 967B4402A9;
	Fri,  1 May 2026 07:52:13 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id B95C040285;
 Fri,  1 May 2026 07:52:12 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id CCE801D000D0;
 Fri,  1 May 2026 01:52:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Fri, 01 May 2026 01:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1777614731;
 x=1777701131; bh=MHH7nc4i/NML6FWplY9JdsT8zeTwHi8VP5hgO9Z+vts=; b=
 snH0nZvveKqJXkoTQyTZWtbJkdJ1J2QKi/zPQYcIVj+q7ZOY/FLBv1Nm8/A/pbDJ
 /bEGn5GXWVrfv0kvdHGRNRmSRI8Pkk+P24/eT9JrhARrP3JEZ8pD+Jvx/0BOF6zm
 wfbLFR4xbg+nFDlasSHFNMSreFMgZIqTDU8ywD0MDHsZZgpjn+l6I4atRo/wprpT
 nmNaXaIGgmSZ4HnpSZKCntrWrg0N+REefzjdIgHaFQwQWdhQMkAlr8BE32RpvJMe
 /HXkmhYNHyE5ub5CX+YBI8qI7rsx1gfXWyiVj8ZEltjkmi2TMYNs6igIvLY193r1
 WTA4EhwLIjKf4MsQ7B+krg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777614731; x=
 1777701131; bh=MHH7nc4i/NML6FWplY9JdsT8zeTwHi8VP5hgO9Z+vts=; b=p
 KXbS02jVj99GX41nDRg6gyQI0z0AvcFm4/p0EZM75daKaSpFQ3lQVK81bSKSa+X6
 y4JB/OMiBBY8pjT43Kj7DzKACX1TpxV1UD2PezyA0hkgOP8iQqN9guXuBAJFyhMi
 +ar1BxnbOv+r9FYNzcxWctpeBNLBqMvL6upjLfdKz0HcbsOCqooUHE6gRIyYdaVj
 QLu3tJFwVjZGBqhC+LCRrM/wqRFEGAWTOY0dVDye28+Cc4zuu+SeM/qrm9gTzMFP
 qx8GCqvR9EAhBFoXcuxB3iad5K36fhScYG/0lLsLNwYjtcCfdliKDVAx2cKXnqNh
 THBqKf7w1YSe8m80X86oA==
X-ME-Sender: <xms:iz_0aTz05o21P_eLqf8izs9a1Ibc5IUFehj-PANdMhj-OaPmV3nMMA>
 <xme:iz_0aUM_EB7PLll4jPbMYpOpWIq_0UKf7cvN9RJ_8iwI1HgOmagmPWWCpG0chfogt
 7wV4RzD_z16xGUqrQ9WG522l-hn4A9MzjhWQa4UjouEuvfKPaK5Dw>
X-ME-Received: <xmr:iz_0aY5pvieW0r4sabm2YOK-4u_BB-69SI1bxfY32SW683sLKYPr2o46wMygD52D6hTg5uMsisO_2Qt60ryYR5DICA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekleegudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgrthdrkhhhrghlihhliheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 shhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegurghvihgurdhmrghrtghhrg
 hnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughs
 ohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohephhgvmhgrnhhtrdgrghhrrgifrghlse
 hngihprdgtohhm
X-ME-Proxy: <xmx:iz_0adnGQWk3_CsKwkiGdzsK2oI7MmP2AizPmBfV2yoUUfAxi8PsIg>
 <xmx:iz_0aRT7d7AdivIZ068xOJlPdjZa3zgPUl-ygzkLd0IBcFcBbgV_Qg>
 <xmx:iz_0aUFPB6GHXuhCORFnzyUw7p2hRg0iNcS3uN_zDqbr-Kq57xa5EA>
 <xmx:iz_0aeHzsvU_VzQ7RQ8mHToLwpYB2GFSaHO4KmuksqMSChoVeG1qeQ>
 <xmx:iz_0abJYHrZ-UPu63XMdtLHjgDvHkKLPAD6MLrfH-M1JtBAQ3aY5Pqyf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 01:52:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v2] devtools: fix SPDX tag check
Date: Fri, 01 May 2026 07:52:09 +0200
Message-ID: <15732573.JCcGWNJJiE@thomas>
In-Reply-To: <e59b182563e5498ea993d48663d8716a@huawei.com>
References: <20260429130935.3681177-1-thomas@monjalon.net>
 <20260430131600.329636-1-thomas@monjalon.net>
 <e59b182563e5498ea993d48663d8716a@huawei.com>
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

30/04/2026 15:30, Marat Khalili:
> > diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
> > index 2390941c74..41fc1fe01d 100755
> > --- a/devtools/check-spdx-tag.sh
> > +++ b/devtools/check-spdx-tag.sh
> > @@ -39,10 +39,8 @@ check_spdx() {
> >      fi
> > 
> >      files_without_spdx=$(cat $tmpfile)
> > -    git grep -LE '(/\*|#|;|\.\.) *SPDX-License-Identifier: [A-Z(]' -- $no_license_list > $tmpfile
> > -    for file in $files_without_spdx ; do
> > -	sed -i "/^$file$/d" $tmpfile
> > -    done
> > +    git grep -LE '(/\*|#|;|\.\.) *SPDX-License-Identifier: [A-Z(]' -- $no_license_list |
> > +    grep -vF "$files_without_spdx" > $tmpfile
> > 
> >      warnings=$(($warnings + $(wc -l < $tmpfile)))
> >      $quiet || cat $tmpfile
> > --
> > 2.53.0
> 
> Sorry for forgetting to mention it right away, some kind of sentinel or if
> condition is needed if $files_without_spdx can be empty, don't know how
> realistic it is in practice and whether other parts are ready to handle this
> case. E.g. `files_without_spdx=$(echo //sentinel; cat $tmpfile)`. I hope it
> won't make the whole thing too complicated and not worth it.

Sorry I don't understand the need for a sentinel.
The script is working fine with an empty files_without_spdx.


