Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF2EC282D0
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 01:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E73E402A0;
	Wed,  5 Mar 2025 02:34:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 20E0A402A0
 for <dev@dpdk.org>; Wed,  5 Mar 2025 02:34:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741138467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R6uuk+DcMIZfpAUla9BoYZG9rCOBN0Xmapkg3B1h+j8=;
 b=IlaslW7TxQx5WlRLGBsq5sIQ+krvGrOm6l6hhZ43w0UUBFHl+4FuWHZHN/MxkmxkJ0WGfC
 LA9EMwR4KJq3HsEb4MHy8Qu/4hXHzceWULmMJR33ZgBQ1gwLjkjNzdEIOr3NT9r0J5tbqS
 pJsA9+u7SIOp30x7WEbOZwcDz2dZZnQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-uFhZpkyQN_6ArCkLHetUCw-1; Tue,
 04 Mar 2025 20:34:23 -0500
X-MC-Unique: uFhZpkyQN_6ArCkLHetUCw-1
X-Mimecast-MFC-AGG-ID: uFhZpkyQN_6ArCkLHetUCw_1741138458
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E32611944F05; Wed,  5 Mar 2025 01:34:16 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.81.152])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7A111955E93; Wed,  5 Mar 2025 01:33:52 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org, Aaron Conole <aconole@redhat.com>,
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
 Evgeny Schemeilin <evgenys@amazon.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Gaetan Rivet <grive@u256.net>,
 Gagandeep Singh <g.singh@nxp.com>,
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
 Jeroen de Borst <jeroendb@google.com>, Jian Wang <jianwang@trustnetic.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jiayu Hu <hujiayu.hu@foxmail.com>,
 Jie Hai <haijie1@huawei.com>, Jingjing Wu <jingjing.wu@intel.com>,
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
 Maciej Czekaj <mczekaj@marvell.com>, maintainers@dpdk.org
Subject: [RFC] doc: Document frequency and volume limits on patches.
Date: Tue,  4 Mar 2025 20:33:51 -0500
Message-ID: <20250305013351.2209789-1-aconole@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: las4Nl84rfRyx4lmQzd7uFLSc-jQE_JpV637lExIO34_1741138458
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The DPDK project has two constrained resources - reviewers and
public CI infrastructure.  These are shared among the entire
project, and there are true costs associated with using these
resources.  Thus, there are two motivations behind this change:
  - Encourage developers to spend more time ensuring their
    changes are in a state that things have gone through some
    basic testing
  - Encourage people to give reviews by guaranteeing that the
    time between series is long enough that comments will be
    valid.

We want to document the guidelines for submitting to the list
to encourage more time for reviews, and also encourage
developers to spend a bit more time to put their submissions
in a 'default accept' condition.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
NOTE: This is a discussion item from the techboard and I'm
      submitting as RFC first to gather feedback.  I've CC'd
      each maintainer individually as well to try and make sure
      it gets into the inboxes.

 doc/guides/contributing/patches.rst | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index d21ee288b2..a13f79c7a8 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -644,6 +644,37 @@ environment) by the person named.
 person.
 
 
+Frequency and volume of patches
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Please allow at least 24 hours to pass between posting patch revisions.
+This ensures reviewers from different geographical regions have time to
+provide feedback.
+Additionally, please do not wait too long (read: weeks) between revisions
+as this makes it harder for reviewers and maintainers to recall the context
+of the previous posting.
+
+Please do not post new revisions without addressing all feedback.
+Make sure that all outstanding items have been addressed before posting a new
+revision for review.
+Do not post a new version of a patch while there is ongoing discussion unless
+a reviewer has specifically requested it.
+
+Do not post your patches to the list in lieu of running tests.
+**YOU MUST ENSURE** that your patches are ready by testing them locally before
+posting to the mailing list.
+The infrastructure running the tests is a shared resource among all developers
+on the project, and many frequent reposts will result in delays for all
+developers.
+We do our best to include CI and self-test infrastructure that can be used on
+an individual developer basis.
+
+Your changes are expected to pass on an x86/x86-64 linux system.
+
+Keep all patch sets to a reasonable length.
+Too many or too large patches and series can quickly become very difficult
+for a reasonable review.
+
 
 Steps to getting your patch merged
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.47.1

