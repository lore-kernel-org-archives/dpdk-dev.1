Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC13FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25EF140B99;
	Wed, 29 Apr 2026 13:48:11 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9F08740A67
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:48:09 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7BB4C205F2;
 Wed, 29 Apr 2026 13:48:09 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Intel IAVF base driver structure definition is wrong
Date: Wed, 29 Apr 2026 13:48:06 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6582E@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel IAVF base driver structure definition is wrong
Thread-Index: AdzXysuEY9JJ5dDmROuhG7qnnxXUCQAAeYpA
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
Cc: <dev@dpdk.org>
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

Hi Vladimir,

This build failure seems to be caused by a bug in the IAVF base driver:
https://github.com/ovsrobot/dpdk/actions/runs/25104438552/job/73561907869=
#step:19:803

struct virtchnl_rss_key {
	u16 vsi_id;
	u16 key_len;
	u8 key[1];         /* RSS hash key, packed bytes */
};

The "key[1]" should be "key[]".
And when copying to it, remember to change "sizeof(struct =
virtchnl_rss_key) - 1" to "sizeof(struct virtchnl_rss_key)".

Other Intel drivers may have the same bug.


Venlig hilsen / Kind regards,
-Morten Br=F8rup


-----Original Message-----
From: 0-day Robot [mailto:robot@bytheb.org]=20
Sent: Wednesday, 29 April 2026 13.25
To: test-report@dpdk.org
Cc: Morten Br=F8rup; robot@bytheb.org
Subject: |FAILURE| pw163367 [PATCH v9] eal/x86: optimize memcpy of small =
sizes

From: robot@bytheb.org

Test-Label: github-robot: build
Test-Status: FAILURE
https://patchwork.dpdk.org/patch/163367/

_github build: failed_
Build URL: https://github.com/ovsrobot/dpdk/actions/runs/25104438552
