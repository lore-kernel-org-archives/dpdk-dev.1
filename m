Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6302C98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 16:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA50B42F02;
	Wed, 23 Sep 2026 18:53:20 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 1038C42E81
 for <dev@dpdk.org>; Wed, 23 Sep 2026 18:53:20 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469b355ffso614204b3a.1
 for <dev@dpdk.org>; Wed, 23 Sep 2026 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790182399;
 x=1790787199; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L9zIjaqEKjZRdmyAmvT1xU/TGSI/b1KlewHpTZbuzuM=;
 b=FwmPgHe4V4OwD6tf4AFI5K6i/zv0Doyd3OyOB31Pcm4mB/wgPqlHs9s5vWFLFS2dYf
 4ZOJJh4V7qtfFqw0m74m7D4xXv1bksAsXlboGdizXz14y1/gENd7NanCsJd+wnVd0MMw
 7kHxIAHJGLPMMsuAE5vYjUrdLSw10zuebi+Hb8kY7qLx4WUvmR/XEcJfc2GW4I9an/ET
 wbKI0MAdi0fZ4af3CAB5Cs858sRWxvMcCTJeEbjfg/OXYMAr3FpytDrJHZWq8w4cLaS8
 ZTYNuKV9BL7Ft6qChdrFgj9y61AWB7rJO8fOhw5UTauoPrAUJ2XG4bvx4SFHODFqUGYw
 Zm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790182399; x=1790787199;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L9zIjaqEKjZRdmyAmvT1xU/TGSI/b1KlewHpTZbuzuM=;
 b=OMq7WOKa9CWjN3yeSvXkgyEPD54J5Q1Sfw2NSMrhgZXpeMvTGKxFxeWSLLGqwaHkkj
 PBsgaugSMyzUVUQz7jTAJTkIKgJ9w/7kzFLeCYq+id8mDa/GTmWFJHImCtjEwKBRXRo8
 AmccInJIqDYx9k7/5Vm66stw0jmDPczV62YS/OtUrODvskRASLy8WiZFyA/oZ8W0yvVX
 xqQdYLsI6ZlaHoMgCWu3euMvZ5ovIKYktmlNE2l7yFl76U+iak4jqe4V1Wulfq2SCVH1
 0iLkQ5noDmB9Dj/8Iy7CNo6KBWft2sljDTBT1hCq6uNlyZ0UYS4sZ9eAnnx7OdOAxZpX
 rfIg==
X-Gm-Message-State: AFuF++mQeCyMDGJFrbA667H0UXiYRDCFUhzIFys186iGxwSaiCHWwctr
 Xt3LCsH/PoepqNPFFCVohE7DeqKeaQsa8yYszZIfMZFI5yG0yQ98HGFov3e0Wuo0250=
X-Gm-Gg: AYBFou0bRxpkyUdgQqf7D63et2Jugv0eyFs1Ltg4ZLt81rr/A9KLr7c6sXr+ohxEB9T
 UX8ggYSvvQgC+ZzeTHoz4Vx3wSIkNVRPRn0PdyIXFNyPz0d00JteriJOUYQRFo+HvOT7gcaZAn/
 jdbOqFjWvF/OiJbjafRUS3593jN4dJ3e3mgqiVFoCcV5qZv83NZB6mXIXPNYKFtHf4EeoivqTDc
 afvCFPLRlXOs1G6Rn9Eu/uV8V0kaDd5xZAzY8HrSm43POecKQnPUqezFd0FQ6ufjSYvA+Wi985u
 AHr+mcm902ovRFqSexg0NwxXjvK5COR9K+K5kg0KHdQDF4E+YVo28TZmX+WIYIddPl0SAbYz/4f
 lRlqZPbDyJvLPdfqR1P06EvUUHMWlm4qh7V8W+YkZXAOyAM6Sj3NokPK11xFQYyIxuJhY1/4P6s
 vKrAMxomtwDRA+fR+Gby9RwqyYbAJDUPk+PR8+pyB969rYUSPMDkUwlMZpmE4DcNk8fsbyUdIiy
 1f07Xbnx5EZlFlvR497u8soIOvZkPfffd5g2yUY
X-Received: by 2002:a05:6a00:4b15:b0:878:393e:26a7 with SMTP id
 d2e1a72fcca58-87d1dee4957mr2623689b3a.60.1790182398955; 
 Wed, 23 Sep 2026 09:53:18 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1cec2d34sm1643189b3a.14.2026.09.23.09.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 09:53:18 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:53:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>, Shepard Siegel <shepard.siegel@atomicrules.com>, Ed
 Czeck <ed.czeck@atomicrules.com>, John Miller
 <john.miller@atomicrules.com>, Igor Russkikh <irusskikh@marvell.com>,
 Steven Webster <steven.webster@windriver.com>, Matt Peters
 <matt.peters@windriver.com>, Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Praveen Shetty <praveen.shetty@intel.com>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>, Gagandeep Singh
 <g.singh@nxp.com>, Vanshika Shukla <vanshika.shukla@nxp.com>, John Daley
 <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>, Gaetan Rivet
 <grive@u256.net>, Joshua Washington <joshwash@google.com>, Xiaoyun Wang
 <cloud.wangxiaoyun@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>,
 Xingui Yang <yangxingui@huawei.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>, Andrew
 Boyer <andrew.boyer@amd.com>, Rosen Xu <rosen.xu@altera.com>, Wei Hu
 <weh@microsoft.com>, Jakub Grajciar <jgrajcia@cisco.com>, Matan Azrad
 <matan@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Zyta Szpak
 <zyta@marvell.com>, Liron Himi <lironh@marvell.com>, Dimon Zhao
 <dimon.zhao@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam
 Chen <sam.chen@nebula-matrix.com>, Martin Spinler <spinler@cesnet.cz>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Christian Koue Muf <ckm@napatech.com>, Serhii Iliushyk
 <sil-plv@napatech.com>, Vamsi Attunuru <vattunuru@marvell.com>, Devendra
 Singh Rawat <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>,
 Howard Wang <howard_wang@realsil.com.cn>, Chunhao Lin <hau@realtek.com>,
 Xing Wang <xing_wang@realsil.com.cn>, Javen Xu <javen_xu@realsil.com.cn>,
 Wenbo Cao <caowenbo@mucse.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Jie Liu <liujie5@linkdatatechnology.com>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Jochen Behrens <jochen.behrens@broadcom.com>, Renyong
 Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>, Rong Qian
 <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>, Dongwei
 Xu <xudw@yunsilicon.com>, Junlong Wang <wang.junlong1@zte.com.cn>, Ming Ran
 <ran.ming@zte.com.cn>
Subject: Re: [PATCH 3/3] doc: simplify NIC feature matrices
Message-ID: <20260923095314.517ff931@phoenix.local>
In-Reply-To: <20260923032502.770744-4-thomas@monjalon.net>
References: <20260923032502.770744-1-thomas@monjalon.net>
 <20260923032502.770744-4-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 23 Sep 2026 05:20:51 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> Remove rows which are not useful in the NIC feature overview:
> documentation availability, basic stats and link status.
> The last two are always implemented so they are not really useful
> in the matrix but their description are kept in features.rst.
> 
> Merge Rx/Tx variants when the support is identical:
> descriptor status and runtime queue setup.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Looks good, I checked build.
You should update the fields you are removing in the overview part.

Other changes that would help in this area:
   - have check-doc-vs-code cover all the features
   - make sure AGENTS.md has coverage of the features doc
   - make sure all offloads covered. I notice rx timestamp isn't

Might be good to split up into multiple tables?
   - OS support
   - Arch support
   - Ethdev ops
   - Offloads

PS: AI is good at auditing and refactoring docs like this.


AI review found:
Review: [PATCH 1/3..3/3] doc: overview matrices and NIC feature cleanup
From: Thomas Monjalon <thomas@monjalon.net>

Series summary

Patch 3 does not apply to main (626b7f1). The ice.ini context changed
in 0cc7493 ("net/ice: enable context desc offloads for vector Tx"),
which flipped Inner L3/L4 checksum from P to Y. Trivial rebase. After
fixing ice.ini by hand, no removed key remains in any ini file.

Post-rebase html build (Sphinx 9.1.0, rtd theme 3.1.0) is clean, no
unknown-feature warnings from conf.py. All generated tables carry the
matrix class. Rx/Tx values were identical in every ini before the
merge (27 descriptor status, 13 runtime queue setup). The single
header row takes row-odd, so tbody tr.row-even selects the same rows
as the old nth-child(2n-1).


Patch 1/3: doc: move CSS of overview matrices

Warning:

- generate_overview_table() still takes table_id, which only existed
  to build the #idN selectors in print_table_css(). All 21 callers in
  setup() still pass it. Drop the parameter and the arguments.

Info:

- The .align-default qualifier is there only to reach specificity
  (0,4,x) and beat rtd rules such as
  ".rst-content table.docutils:not(.field-list) tr:nth-child(2n-1) td".
  That class comes from a Sphinx transform added in 2.1. With older
  Sphinx (1.7 on RHEL 8) most matrix rules stop matching and the
  table renders unstyled; the ID selectors had no such dependency.
  Repeating the class (table.matrix.matrix.docutils) gives the same
  specificity without relying on Sphinx internals.


Patch 3/3: doc: simplify NIC feature matrices

Warning:

- doc/guides/nics/overview.rst line 22 still lists "documentation
  availability" among the differences summarized below. No longer
  true once the Usage/Design/Perf doc rows are removed.

Info:

- mana.ini had "Link status = P": mana_dev_link_update() always
  reports up at a fixed 100G since MANA has no carrier state. The
  matrix was the only place this showed; mana.rst does not mention
  it. Worth a line in the mana.rst limitations.

- features.rst Basic stats says "These apply to all drivers." Link
  status is kept for the same reason but has no such note. Add it so
  readers do not go looking for the row in the matrix.

- vdpadevs/features/default.ini still has Usage doc, Design doc and
  Perf doc rows. Same rationale applies; follow-up patch.

- Commit message: "their description are kept" should be "their
  descriptions are kept".
