Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AE8C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 12:26:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F602402DF;
	Wed, 26 Mar 2025 13:26:58 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 453FD402DA;
 Wed, 26 Mar 2025 13:26:56 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E08812064E;
 Wed, 26 Mar 2025 13:26:55 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC v4 0/8] Symbol versioning and export rework
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 26 Mar 2025 13:26:54 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB72@smartserver.smartshare.dk>
In-Reply-To: <CAJFAV8xiZB8r9=5D2tpc9Onrh+7582ZzM8cY_2VHojaQ7xe=BQ@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC v4 0/8] Symbol versioning and export rework
Thread-Index: AdueRv66/im00uycQaiI/2jjle8amAAAczSg
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250317154308.2782689-1-david.marchand@redhat.com>
 <CAJFAV8xiZB8r9=5D2tpc9Onrh+7582ZzM8cY_2VHojaQ7xe=BQ@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>, <thomas@monjalon.net>,
 <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, <andremue@linux.microsoft.com>,
 "dpdk-techboard" <techboard@dpdk.org>
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

PiBGcm9tOiBEYXZpZCBNYXJjaGFuZCBbbWFpbHRvOmRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb21d
DQo+IFNlbnQ6IFdlZG5lc2RheSwgMjYgTWFyY2ggMjAyNSAxMy4wMw0KPiANCg0KWy4uLl0NCg0K
PiBBbmQgSSBkb24ndCBzZWUgc3ltYm9sIHZlcnNpb25pbmcgYXMgYSBNVVNUIGluZnJhc3RydWN0
dXJlIHRoYXQgRFBESw0KPiBuZWVkcyB0byBwcm92aWRlIHRvIGRhdGFwYXRoIGFwcGxpY2F0aW9u
cy4NCg0KQWdyZWUuDQpHZXR0aW5nIHJpZCBvZiB0aGUgZXhvdGljIHN0dWZmIGxpa2Ugc3ltYm9s
IHZlcnNpb25pbmcgd291bGQgbWFrZSB0aGUgRFBESyBBUEkgZWFzaWVyIHVuZGVyc3RhbmRhYmxl
IGZvciBEUERLIGFwcGxpY2F0aW9uIGRldmVsb3BlcnMuDQpBbHNvLCBpdCdzIG15IGltcHJlc3Np
b24gdGhhdCBzeW1ib2wgdmVyc2lvbmluZyBkb2VzIG5vdCByZWFsbHkgcGxheSBhIG1ham9yIHJv
bGUgaW4ga2VlcGluZyBvciBicmVha2luZyBBQkkgY29tcGF0aWJpbGl0eS4NCkNvbmNsdXNpb246
IE5vdCB3b3J0aCB0aGUgY29tcGxleGl0eS4NCg0K
