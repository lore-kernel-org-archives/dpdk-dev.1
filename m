Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348F6C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 16:47:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1B37402C4;
	Wed, 19 Mar 2025 17:47:50 +0100 (CET)
Received: from flow-a6-smtp.messagingengine.com
 (flow-a6-smtp.messagingengine.com [103.168.172.141])
 by mails.dpdk.org (Postfix) with ESMTP id 75F0F4026B;
 Wed, 19 Mar 2025 17:47:48 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailflow.phl.internal (Postfix) with ESMTP id B1E0B201879;
 Wed, 19 Mar 2025 12:47:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 19 Mar 2025 12:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742402867;
 x=1742410067; bh=R3cT9auhgwJU/DuESNMFvPikXlObMPmCSbpdW0qn9D8=; b=
 XYQSZZbrs3AL1scygAwVzINkAyC+tb4uc/y0Xe5DzJS7NU6+rt8vLrAFzoyHeCD9
 2rbiP/OrdnCfA/O1NTEccv8PGOEvrgXgYR3faTT57fBVxKxZ1bWenKspYWwvJFfi
 lKVOxcB8vyrbgxBVAzmRv6LpUH7Uhb7uv0jNxXftDzhC1l4JuFDfi4WkCBFoR/fI
 sx3gjffcdxPlSCbDN6idG7f9WqMsNIBfFx9BYsCX7N3nomwV1/1006luMoX+qoH3
 yUUbeeuHwY4KVn8WZa3OzwjN/4bEsxh3ooQEZnusjz6Hsqe6PA6R/uO+yhZMmg1H
 KIVUpwJ9B7IMyknh96nStA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742402867; x=
 1742410067; bh=R3cT9auhgwJU/DuESNMFvPikXlObMPmCSbpdW0qn9D8=; b=E
 Zz0cu3ljzLP41JiXz8IyGuuGTGcylj1Ar2WgbB0oCqt5SvM19kEtxeQUYmUhG6Mh
 DrKx0hF6jKD+pYfItaSrqr+YX2E4S6cp7tsomrjs2Ra7cDU9bN+ZDqa2KEyrzvI0
 A1iwzcyg5n3gWNpMIPUY/zyo5In5QdyswEf044DwPkVeCs0Ko3HKyaDxGK0umyU+
 9HuvBJ+LjUSyLviLt6sKacTTV3YZn445uFdDOIIfBwLn7IR0A1fobBAm173x2JU4
 W+c5kNoThDbuGpCrWXPduavxJ8r9H1zqnDoSOZZSCkww5wOBBpl30AZ0ULmi9OK2
 /UO0QGBK80hF0/ip2o/5A==
X-ME-Sender: <xms:LvXaZ9nRC1x-VBwwibqcpcOqBrp1eO8oVINBjbTtfrawmlDsIwMkSA>
 <xme:LvXaZ41rk7mr2AIA7pX5kjPN7cK5JnerIyZMKHqeLRXyWZbvCxgIIi_4sjytMwyGL
 cagcOq9CbGWx827jQ>
X-ME-Received: <xmr:LvXaZzrRwdkuCTVsS5sTVF99ctHQRdm_wpNB0aCNbda5PUolNpS-vWbirsrAXLCLF2DEK-XIQfXIQmGGkru3F-onTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehkeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeelvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
 gtohhnohhlvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdho
 rhhgpdhrtghpthhtohepthgvtghhsghorghrugesughpughkrdhorhhgpdhrtghpthhtoh
 eprggshhhinhgrnhgurghnrdhguhhjjhgrrhesihhnthgvlhdrtghomhdprhgtphhtthho
 pegrjhhithdrkhhhrghprghruggvsegsrhhorggutghomhdrtghomhdprhgtphhtthhope
 hgrghkhhhilhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehprghlohhksehmrghr
 vhgvlhhlrdgtohhmpdhrtghpthhtoheprghmrghnrdguvggvphdrshhinhhghhesihhnth
 gvlhdrtghomhdprhgtphhtthhopegrmhhithgsvghrnhesrghmrgiiohhnrdgtohhm
X-ME-Proxy: <xmx:LvXaZ9md20uLXSF6Vm3-PnAhIJz79HGsdTceU8o1z1EFnTAdgMwKvw>
 <xmx:LvXaZ73vooqgBTX8jfOn5lRoIRZHIgV0g8t4JZDxV-Z7n2G07riAXQ>
 <xmx:LvXaZ8t95tOojedXetILP_-6JBA6kHZvzITW3sOjAv6vjO8wudY20A>
 <xmx:LvXaZ_WC6cGU-1TW8Mh2bXgvM7dBX_C39-xjOWAYYcJwj7UWyBT-lA>
 <xmx:M_XaZxK25-YnH_6m4kVt-2uWwh9QRdzGB4iyDHUPIGJYLIOfO9MC4eBu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 12:47:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org, techboard@dpdk.org,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Akhil Goyal <gakhil@marvell.com>, Alok Prasad <palok@marvell.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Amit Bernstein <amitbern@amazon.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Boyer <andrew.boyer@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Apeksha Gupta <apeksha.gupta@nxp.com>,
 "Artem V . Andreev" <artem.andreev@oktetlabs.ru>,
 Ashish Gupta <ashish.gupta@marvell.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>, Bing Zhao <bingz@nvidia.com>,
 Brian Dooley <brian.dooley@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Byron Marohn <byron.marohn@intel.com>,
 Chaoyong He <chaoyong.he@corigine.com>, Chas Williams <chas3@att.com>,
 Chenbo Xia <chenbox@nvidia.com>, Cheng Jiang <honest.jiang@foxmail.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Christian Koue Muf <ckm@napatech.com>, Chunhao Lin <hau@realtek.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Conor Walsh <conor.walsh@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 David Christensen <drc@linux.ibm.com>, David Hunt <david.hunt@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Dongwei Xu <xudw@yunsilicon.com>, Ed Czeck <ed.czeck@atomicrules.com>,
 Elena Agostini <eagostini@nvidia.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Evgeny Schemeilin <evgenys@amazon.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Gaetan Rivet <grive@u256.net>, Gagandeep Singh <g.singh@nxp.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Hanxiao Li <li.hanxiao@zte.com.cn>, Harman Kalra <hkalra@marvell.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Howard Wang <howard_wang@realsil.com.cn>,
 Hyong Youb Kim <hyonkim@cisco.com>, Ian Stokes <ian.stokes@intel.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Jakub Grajciar <jgrajcia@cisco.com>, Jakub Palider <jpalider@marvell.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>,
 Jay Zhou <jianjay.zhou@huawei.com>, Jerin Jacob <jerinj@marvell.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Jian Wang <jianwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jiayu Hu <hujiayu.hu@foxmail.com>, Jie Hai <haijie1@huawei.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 John Daley <johndale@cisco.com>, John McNamara <john.mcnamara@intel.com>,
 John Miller <john.miller@atomicrules.com>,
 "John W . Linville" <linville@tuxdriver.com>,
 Joshua Washington <joshwash@google.com>,
 Julien Aube <julien_dpdk@jaube.fr>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Kai Ji <kai.ji@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Kevin Traynor <ktraynor@redhat.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Kirill Rybalchenko <kirill.rybalchenko@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Lee Daly <lee.daly@intel.com>, Liang Ma <liangma@liangbit.com>,
 Lijie Shan <shan.lijie@zte.com.cn>, Liron Himi <lironh@marvell.com>,
 Long Li <longli@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Maciej Czekaj <mczekaj@marvell.com>
Subject: Re: [RFC] doc: Document frequency and volume limits on patches.
Date: Wed, 19 Mar 2025 17:47:29 +0100
Message-ID: <3837048.otsE0voPBg@thomas>
In-Reply-To: <20250305013351.2209789-1-aconole@redhat.com>
References: <20250305013351.2209789-1-aconole@redhat.com>
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

Hello,

05/03/2025 02:33, Aaron Conole:
> The DPDK project has two constrained resources - reviewers and
> public CI infrastructure.  These are shared among the entire
> project, and there are true costs associated with using these
> resources.  Thus, there are two motivations behind this change:
>   - Encourage developers to spend more time ensuring their
>     changes are in a state that things have gone through some
>     basic testing
>   - Encourage people to give reviews by guaranteeing that the
>     time between series is long enough that comments will be
>     valid.

Thanks for trying to improve our process.

> We want to document the guidelines for submitting to the list
> to encourage more time for reviews, and also encourage
> developers to spend a bit more time to put their submissions
> in a 'default accept' condition.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
> +Frequency and volume of patches
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Please allow at least 24 hours to pass between posting patch revisions.
> +This ensures reviewers from different geographical regions have time to
> +provide feedback.
> +Additionally, please do not wait too long (read: weeks) between revisions
> +as this makes it harder for reviewers and maintainers to recall the context
> +of the previous posting.

Should we recommend to ping after a week of inactivity?

> +
> +Please do not post new revisions without addressing all feedback.
> +Make sure that all outstanding items have been addressed before posting a new
> +revision for review.

Should we remind to reply to all feedbacks?

> +Do not post a new version of a patch while there is ongoing discussion unless
> +a reviewer has specifically requested it.
> +
> +Do not post your patches to the list in lieu of running tests.
> +**YOU MUST ENSURE** that your patches are ready by testing them locally before

Should we be more precise about "testing them locally"?
Or recommend minimal testing like 1 compilation target with unit test or DTS?

> +posting to the mailing list.
> +The infrastructure running the tests is a shared resource among all developers
> +on the project, and many frequent reposts will result in delays for all
> +developers.
> +We do our best to include CI and self-test infrastructure that can be used on
> +an individual developer basis.

This self test infra should be explained a bit more.

> +
> +Your changes are expected to pass on an x86/x86-64 linux system.

This can be moved above with "local test" recommendation.

> +
> +Keep all patch sets to a reasonable length.
> +Too many or too large patches and series can quickly become very difficult
> +for a reasonable review.

To be clear, you recommend to split patches and series appropriately.

Thanks again.
I would love reading more comments and feedbacks about this.


