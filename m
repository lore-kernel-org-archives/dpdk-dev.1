Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413D5C43327
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:40:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B017E40652;
	Tue, 30 Jun 2026 13:40:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id B8EF540278
 for <dev@dpdk.org>; Tue, 30 Jun 2026 13:40:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782819621; x=1814355621;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ykV2nT+fVUE2TKguqhvN/gJi5FLPIs5hSSx4PznoTX8=;
 b=BNx6PU1m+tWPQAEBaamMiX03Y7Rq7UxvbFZxi7GtujopqfoJdaZaVns+
 TX1eoIOqCMojONEWT8UgkhKGTwaEYY2CUVgza7VMJJIAWhnb+gco0vYce
 mkUabqtCgM0QBmDydlb4CMOezlytiR1+7aCOL0bjblRcdXfrZup8XReRu
 OKle5ZfwsYoWjhID7kTW/7Foy4J79Xwf0lwvKsp0/E6Ni5fG59s1BOkTe
 ZaMVZOhHQhiTAazL4TQaq/CAPMy8pfKqdl4zNNkxS1zpUDGqm3wPumuf4
 X6gYilQGN3+VbHewSmo6qLptHt+xYQoEJNFZzsCGMpP+evn9IJl6F9elM A==;
X-CSE-ConnectionGUID: pW47M6PAQk2BGAkv+3oy8A==
X-CSE-MsgGUID: qaPgCevcROmd+abLoTKuew==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82643716"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="82643716"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 04:40:20 -0700
X-CSE-ConnectionGUID: kLsRGKfYSSSOcttZJS5IeQ==
X-CSE-MsgGUID: 3oPwhDz2TPGwp4VR/ce1uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="245891133"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2026 04:40:19 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v3 1/6] net/iavf: increase max ring descriptors to hardware
 limit
Date: Tue, 30 Jun 2026 08:06:51 -0400
Message-ID: <20260630120657.1046588-2-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630120657.1046588-1-dawid.wesierski@intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
 <20260630120657.1046588-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

RnJvbTogTWFyZWsgS2FzaWV3aWN6IDxtYXJlay5rYXNpZXdpY3pAaW50ZWwuY29tPgoKVGhlIElu
dGVsIEU4MTAgaGFyZHdhcmUgc3VwcG9ydHMgdXAgdG8gODE2MCAoOEsgLSAzMikgZGVzY3JpcHRv
cnMgcGVyClRYL1JYIHJpbmcsIGJ1dCBJQVZGX01BWF9SSU5HX0RFU0MgY2FwcyBpdCBhdCA0MDk2
LiBBcHBsaWNhdGlvbnMgdGhhdApuZWVkIGRlZXAgZGVzY3JpcHRvciByaW5ncyBmb3IgaGFyZHdh
cmUgcmF0ZS1saW1pdGVkIHBhY2luZyAoZS5nLiwKU1QyMTEwIHZpZGVvIHdpdGggdGhvdXNhbmRz
IG9mIHBhY2tldHMgcGVyIGZyYW1lKSBjYW5ub3QgcXVldWUgZW5vdWdoCnBhY2tldHMgYmVmb3Jl
IHRoZSBwYWNpbmcgZXBvY2ggYmVnaW5zLgoKSW5jcmVhc2UgSUFWRl9NQVhfUklOR19ERVNDIHRv
IHRoZSBoYXJkd2FyZSBtYXhpbXVtIG9mIDgxNjAgdG8gYWxsb3cKZnVsbCB1dGlsaXphdGlvbiBv
ZiB0aGUgcmluZyBkZXB0aCBvbiBFODEwIFZGcy4KClNpZ25lZC1vZmYtYnk6IE1hcmVrIEthc2ll
d2ljeiA8bWFyZWsua2FzaWV3aWN6QGludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogRGF3aWQgV2Vz
aWVyc2tpIDxkYXdpZC53ZXNpZXJza2lAaW50ZWwuY29tPgotLS0KIC5tYWlsbWFwICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAyICsrCiBkcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0
eC5oIHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS8ubWFpbG1hcCBiLy5tYWlsbWFwCmluZGV4IDQwMDFlNWZiMGUuLmQ3
YjE3NWRlMmEgMTAwNjQ0Ci0tLSBhLy5tYWlsbWFwCisrKyBiLy5tYWlsbWFwCkBAIC0zNjYsNiAr
MzY2LDcgQEAgRGF2aWQgWmVuZyA8emVuZ3hoc2hAY24uaWJtLmNvbT4KIERhdmlkZSBDYXJhdHRp
IDxkY2FyYXR0aUByZWRoYXQuY29tPgogRGF3aWQgR29yZWNraSA8ZGdyQHNlbWloYWxmLmNvbT4K
IERhd2lkIEp1cmN6YWsgPGRhd2lkX2p1cmVrQHZwLnBsPgorRGF3aWQgV2VzaWVyc2tpIDxkYXdp
ZC53ZXNpZXJza2lAaW50ZWwuY29tPgogRGF3aWQgWmllbGluc2tpIDxkYXdpZC56aWVsaW5za2lA
aW50ZWwuY29tPgogRGF3aWQgxYF1a3dpxYRza2kgPGRhd2lkLmx1a3dpbnNraUBpbnRlbC5jb20+
CiBEYXh1ZSBHYW8gPGRheHVleC5nYW9AaW50ZWwuY29tPgpAQCAtMTAxNCw2ICsxMDE1LDcgQEAg
TWFyY2luIFdpbGsgPG1hcmNpbi53aWxrQGNhdml1bW5ldHdvcmtzLmNvbT4KIE1hcmNpbiBXb2p0
YXMgPG13QHNlbWloYWxmLmNvbT4KIE1hcmNpbiBaYXBvbHNraSA8bWFyY2lueC5hLnphcG9sc2tp
QGludGVsLmNvbT4KIE1hcmNvIFZhcmxlc2UgPG12YXJsZXNlQHN1c2UuZGU+CitNYXJlayBLYXNp
ZXdpY3ogPG1hcmVrLmthc2lld2ljekBpbnRlbC5jb20+CiBNYXJlayBNaWNhbCA8bWFyZWt4Lm1p
Y2FsQGludGVsLmNvbT4KIE1hcmVrIFphbGZyZXNzby1qdW5kemlsbG8gPG1hcmVreC56YWxmcmVz
c28tanVuZHppbGxvQGludGVsLmNvbT4KIE1hcmlhIExpbmdlbWFyayA8bWFyaWEubGluZ2VtYXJr
QGVyaWNzc29uLmNvbT4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9y
eHR4LmggYi9kcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0eC5oCmluZGV4IDg0NDkyMzZk
NGQuLjIyZWE0MTVmNDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9y
eHR4LmgKKysrIGIvZHJpdmVycy9uZXQvaW50ZWwvaWF2Zi9pYXZmX3J4dHguaApAQCAtMTYsNyAr
MTYsNyBAQAogLyogSW4gUUxFTiBtdXN0IGJlIHdob2xlIG51bWJlciBvZiAzMiBkZXNjcmlwdG9y
cy4gKi8KICNkZWZpbmUgSUFWRl9BTElHTl9SSU5HX0RFU0MgICAgICAzMgogI2RlZmluZSBJQVZG
X01JTl9SSU5HX0RFU0MgICAgICAgIDY0Ci0jZGVmaW5lIElBVkZfTUFYX1JJTkdfREVTQyAgICAg
ICAgNDA5NgorI2RlZmluZSBJQVZGX01BWF9SSU5HX0RFU0MgICAgICAgICg4MTkyIC0gMzIpCiAj
ZGVmaW5lIElBVkZfRE1BX01FTV9BTElHTiAgICAgICAgNDA5NgogLyogQmFzZSBhZGRyZXNzIG9m
IHRoZSBIVyBkZXNjcmlwdG9yIHJpbmcgc2hvdWxkIGJlIDEyOEIgYWxpZ25lZC4gKi8KICNkZWZp
bmUgSUFWRl9SSU5HX0JBU0VfQUxJR04gICAgICAxMjgKLS0gCjIuNDcuMwoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CkludGVsIFRlY2hub2xvZ3kgUG9sYW5kIHNwLiB6IG8uby4KdWwuIFNsb3dhY2tpZWdvIDE3MyB8
IDgwLTI5OCBHZGFuc2sgfCBTYWQgUmVqb25vd3kgR2RhbnNrIFBvbG5vYyB8IFZJSSBXeWR6aWFs
IEdvc3BvZGFyY3p5IEtyYWpvd2VnbyBSZWplc3RydSBTYWRvd2VnbyAtIEtSUyAxMDE4ODIgfCBO
SVAgOTU3LTA3LTUyLTMxNiB8IEthcGl0YWwgemFrbGFkb3d5IDIwMC4wMDAgUExOLgpTcG9sa2Eg
b3N3aWFkY3phLCB6ZSBwb3NpYWRhIHN0YXR1cyBkdXplZ28gcHJ6ZWRzaWViaW9yY3kgdyByb3p1
bWllbml1IHVzdGF3eSB6IGRuaWEgOCBtYXJjYSAyMDEzIHIuIG8gcHJ6ZWNpd2R6aWFsYW5pdSBu
YWRtaWVybnltIG9wb3puaWVuaW9tIHcgdHJhbnNha2NqYWNoIGhhbmRsb3d5Y2guCgpUYSB3aWFk
b21vc2Mgd3JheiB6IHphbGFjem5pa2FtaSBqZXN0IHByemV6bmFjem9uYSBkbGEgb2tyZXNsb25l
Z28gYWRyZXNhdGEgaSBtb3plIHphd2llcmFjIGluZm9ybWFjamUgcG91Zm5lLiBXIHJhemllIHBy
enlwYWRrb3dlZ28gb3RyenltYW5pYSB0ZWogd2lhZG9tb3NjaSwgcHJvc2lteSBvIHBvd2lhZG9t
aWVuaWUgbmFkYXdjeSBvcmF6IHRyd2FsZSBqZWogdXN1bmllY2llOyBqYWtpZWtvbHdpZWsgcHJ6
ZWdsYWRhbmllIGx1YiByb3pwb3dzemVjaG5pYW5pZSBqZXN0IHphYnJvbmlvbmUuClRoaXMgZS1t
YWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFs
IGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gSWYgeW91IGFy
ZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBh
bmQgZGVsZXRlIGFsbCBjb3BpZXM7IGFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uIGJ5IG90aGVy
cyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLgo=

