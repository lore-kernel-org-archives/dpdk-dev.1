Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E801C44500
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 11:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A87954067A;
	Fri,  3 Jul 2026 13:53:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id ED019402D4
 for <dev@dpdk.org>; Fri,  3 Jul 2026 13:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783079604; x=1814615604;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dBr5qs/k3PjGZA6M8Fon7ilW3UtrR1rHtGO2rW6nzGY=;
 b=IvxAOj8JgDm1eJuOelN4e9aqoSccL1bhaSEYeQCBs3qy/BuTwJw7ZnnZ
 uXLqqBcU3Ti6yNc3tGX8TbiYotf6VPf+Krj2N4rNEzRZ+sQG87+J1oFqY
 HVTNRnunESylqHs98Fo0Oo2fbvDjRoYBAkhj/YiG5ZZhIQR3Ox12YaAwv
 LLiyoGbst7p6eUrfQEAkkGq1ZBdfhxrw7rOekABy8dGj8SyESLYrA/Pwr
 dHyTNHxg7OmcT7Q40Ito1estANPKrL9NFgu/SGE+NdIeidjnW5zDN0YJF
 oQPu1T7N0psqZI2zQF4hxOIVLt79OKYROjCtlFVmu5/Ceo/RbY8SfyCaI g==;
X-CSE-ConnectionGUID: iGmgxDR1RP2L+mhc1oUK8w==
X-CSE-MsgGUID: Mltr2o+tQSetJnZm3rGp9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101253798"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="101253798"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 04:53:24 -0700
X-CSE-ConnectionGUID: 0+P+LN8pTLuuA669WKiTZg==
X-CSE-MsgGUID: BGwL9EHXSTuDjgh0cTDUQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="291240234"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa001.jf.intel.com with ESMTP; 03 Jul 2026 04:53:22 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v4 1/5] net/iavf: increase max ring descriptors to hardware
 limit
Date: Fri,  3 Jul 2026 08:19:48 -0400
Message-ID: <20260703121952.1277387-2-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703121952.1277387-1-dawid.wesierski@intel.com>
References: <20260630120657.1046588-1-dawid.wesierski@intel.com>
 <20260703121952.1277387-1-dawid.wesierski@intel.com>
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

VGhlIEludGVsIEU4MTAgaGFyZHdhcmUgc3VwcG9ydHMgdXAgdG8gODE2MCAoOEsgLSAzMikgZGVz
Y3JpcHRvcnMgcGVyClRYL1JYIHJpbmcsIGJ1dCBJQVZGX01BWF9SSU5HX0RFU0MgY2FwcyBpdCBh
dCA0MDk2LiBBcHBsaWNhdGlvbnMgdGhhdApuZWVkIGRlZXAgZGVzY3JpcHRvciByaW5ncyBmb3Ig
aGFyZHdhcmUgcmF0ZS1saW1pdGVkIHBhY2luZyAoZS5nLiwKU1QyMTEwIHZpZGVvIHdpdGggdGhv
dXNhbmRzIG9mIHBhY2tldHMgcGVyIGZyYW1lKSBjYW5ub3QgcXVldWUgZW5vdWdoCnBhY2tldHMg
YmVmb3JlIHRoZSBwYWNpbmcgZXBvY2ggYmVnaW5zLgoKSW5jcmVhc2UgSUFWRl9NQVhfUklOR19E
RVNDIHRvIHRoZSBoYXJkd2FyZSBtYXhpbXVtIG9mIDgxNjAgdG8gYWxsb3cKZnVsbCB1dGlsaXph
dGlvbiBvZiB0aGUgcmluZyBkZXB0aCBvbiBFODEwIFZGcy4KClNpZ25lZC1vZmYtYnk6IE1hcmVr
IEthc2lld2ljeiA8bWFyZWsua2FzaWV3aWN6QGludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogRGF3
aWQgV2VzaWVyc2tpIDxkYXdpZC53ZXNpZXJza2lAaW50ZWwuY29tPgotLS0KIC5tYWlsbWFwICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAyICsrCiBkcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lh
dmZfcnh0eC5oIHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS8ubWFpbG1hcCBiLy5tYWlsbWFwCmluZGV4IDQwMDFlNWZi
MGUuLmQ3YjE3NWRlMmEgMTAwNjQ0Ci0tLSBhLy5tYWlsbWFwCisrKyBiLy5tYWlsbWFwCkBAIC0z
NjYsNiArMzY2LDcgQEAgRGF2aWQgWmVuZyA8emVuZ3hoc2hAY24uaWJtLmNvbT4KIERhdmlkZSBD
YXJhdHRpIDxkY2FyYXR0aUByZWRoYXQuY29tPgogRGF3aWQgR29yZWNraSA8ZGdyQHNlbWloYWxm
LmNvbT4KIERhd2lkIEp1cmN6YWsgPGRhd2lkX2p1cmVrQHZwLnBsPgorRGF3aWQgV2VzaWVyc2tp
IDxkYXdpZC53ZXNpZXJza2lAaW50ZWwuY29tPgogRGF3aWQgWmllbGluc2tpIDxkYXdpZC56aWVs
aW5za2lAaW50ZWwuY29tPgogRGF3aWQgxYF1a3dpxYRza2kgPGRhd2lkLmx1a3dpbnNraUBpbnRl
bC5jb20+CiBEYXh1ZSBHYW8gPGRheHVleC5nYW9AaW50ZWwuY29tPgpAQCAtMTAxNCw2ICsxMDE1
LDcgQEAgTWFyY2luIFdpbGsgPG1hcmNpbi53aWxrQGNhdml1bW5ldHdvcmtzLmNvbT4KIE1hcmNp
biBXb2p0YXMgPG13QHNlbWloYWxmLmNvbT4KIE1hcmNpbiBaYXBvbHNraSA8bWFyY2lueC5hLnph
cG9sc2tpQGludGVsLmNvbT4KIE1hcmNvIFZhcmxlc2UgPG12YXJsZXNlQHN1c2UuZGU+CitNYXJl
ayBLYXNpZXdpY3ogPG1hcmVrLmthc2lld2ljekBpbnRlbC5jb20+CiBNYXJlayBNaWNhbCA8bWFy
ZWt4Lm1pY2FsQGludGVsLmNvbT4KIE1hcmVrIFphbGZyZXNzby1qdW5kemlsbG8gPG1hcmVreC56
YWxmcmVzc28tanVuZHppbGxvQGludGVsLmNvbT4KIE1hcmlhIExpbmdlbWFyayA8bWFyaWEubGlu
Z2VtYXJrQGVyaWNzc29uLmNvbT4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2ludGVsL2lhdmYv
aWF2Zl9yeHR4LmggYi9kcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0eC5oCmluZGV4IDg0
NDkyMzZkNGQuLjIyZWE0MTVmNDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2ludGVsL2lhdmYv
aWF2Zl9yeHR4LmgKKysrIGIvZHJpdmVycy9uZXQvaW50ZWwvaWF2Zi9pYXZmX3J4dHguaApAQCAt
MTYsNyArMTYsNyBAQAogLyogSW4gUUxFTiBtdXN0IGJlIHdob2xlIG51bWJlciBvZiAzMiBkZXNj
cmlwdG9ycy4gKi8KICNkZWZpbmUgSUFWRl9BTElHTl9SSU5HX0RFU0MgICAgICAzMgogI2RlZmlu
ZSBJQVZGX01JTl9SSU5HX0RFU0MgICAgICAgIDY0Ci0jZGVmaW5lIElBVkZfTUFYX1JJTkdfREVT
QyAgICAgICAgNDA5NgorI2RlZmluZSBJQVZGX01BWF9SSU5HX0RFU0MgICAgICAgICg4MTkyIC0g
MzIpCiAjZGVmaW5lIElBVkZfRE1BX01FTV9BTElHTiAgICAgICAgNDA5NgogLyogQmFzZSBhZGRy
ZXNzIG9mIHRoZSBIVyBkZXNjcmlwdG9yIHJpbmcgc2hvdWxkIGJlIDEyOEIgYWxpZ25lZC4gKi8K
ICNkZWZpbmUgSUFWRl9SSU5HX0JBU0VfQUxJR04gICAgICAxMjgKLS0gCjIuNDcuMwoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCkludGVsIFRlY2hub2xvZ3kgUG9sYW5kIHNwLiB6IG8uby4KdWwuIFNsb3dhY2tpZWdv
IDE3MyB8IDgwLTI5OCBHZGFuc2sgfCBTYWQgUmVqb25vd3kgR2RhbnNrIFBvbG5vYyB8IFZJSSBX
eWR6aWFsIEdvc3BvZGFyY3p5IEtyYWpvd2VnbyBSZWplc3RydSBTYWRvd2VnbyAtIEtSUyAxMDE4
ODIgfCBOSVAgOTU3LTA3LTUyLTMxNiB8IEthcGl0YWwgemFrbGFkb3d5IDIwMC4wMDAgUExOLgpT
cG9sa2Egb3N3aWFkY3phLCB6ZSBwb3NpYWRhIHN0YXR1cyBkdXplZ28gcHJ6ZWRzaWViaW9yY3kg
dyByb3p1bWllbml1IHVzdGF3eSB6IGRuaWEgOCBtYXJjYSAyMDEzIHIuIG8gcHJ6ZWNpd2R6aWFs
YW5pdSBuYWRtaWVybnltIG9wb3puaWVuaW9tIHcgdHJhbnNha2NqYWNoIGhhbmRsb3d5Y2guCgpU
YSB3aWFkb21vc2Mgd3JheiB6IHphbGFjem5pa2FtaSBqZXN0IHByemV6bmFjem9uYSBkbGEgb2ty
ZXNsb25lZ28gYWRyZXNhdGEgaSBtb3plIHphd2llcmFjIGluZm9ybWFjamUgcG91Zm5lLiBXIHJh
emllIHByenlwYWRrb3dlZ28gb3RyenltYW5pYSB0ZWogd2lhZG9tb3NjaSwgcHJvc2lteSBvIHBv
d2lhZG9taWVuaWUgbmFkYXdjeSBvcmF6IHRyd2FsZSBqZWogdXN1bmllY2llOyBqYWtpZWtvbHdp
ZWsgcHJ6ZWdsYWRhbmllIGx1YiByb3pwb3dzemVjaG5pYW5pZSBqZXN0IHphYnJvbmlvbmUuClRo
aXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1h
dGVyaWFsIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gSWYg
eW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNl
bmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXM7IGFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uIGJ5
IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLgo=

