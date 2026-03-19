Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59011075261
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 06:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EDDC402A7;
	Thu, 19 Mar 2026 07:21:10 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id F3C324013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 07:21:08 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fbwYr57qYz5BNRf;
 Thu, 19 Mar 2026 14:21:04 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl1.zte.com.cn with SMTP id 62J6Krgv075401;
 Thu, 19 Mar 2026 14:20:53 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 19 Mar 2026 14:20:55 +0800
X-Zmail-TransId: 3e8169bb95c3002-845c6
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: thomas@monjalon.net, stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: Re: [v3,
 5/5] net/zxdh: add support for GENEVE TSO and Rx outer checksum
Date: Thu, 19 Mar 2026 13:53:56 +0800
Message-ID: <20260319055356.648384-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260131062208.2445121-6-wang.junlong1@zte.com.cn>
References: <20260131062208.2445121-6-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 62J6Krgv075401
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 19 Mar 2026 14:21:04 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69BB95D0.000/4fbwYr57qYz5BNRf
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



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PiA+IDE4LzAzLzIwMjYgMDM6MjEsIEp1bmxvbmcgV2FuZzoNCj4gPiA+IFNvcnJ5LCBJIGhhdmUg
YSBxdWVzdGlvbi4NCj4gPiA+IFNvbWUgdGltZSBhZ28sIEkgc3VibWl0dGVkIHRoaXMgcGF0Y2gg
KFt2Myw1LzVdIG5ldC96eGRoOiBhZGQgc3VwcG9ydCBmb3IgR0VORVZFIFRTTyBhbmQgUnggb3V0
ZXIgY2hlY2tzdW0pLA0KPiA+ID4gd2hpY2ggd2FzIG1hcmtlZCBhcyBhY2NlcHRlZC4gSG93ZXZl
ciwgd2hlbiBJIGZldGNoZWQgdGhlIGxhdGVzdCBkcGQtbmV4dC1uZXQgY29kZSwgdGhlIGZvci1t
YWluIGJyYW5jaCBkaWQgbm90IGNvbnRhaW4gaXQuDQo+ID4gPiANCj4gPiA+IENvdWxkIHlvdSBw
bGVhc2UgbGV0IG1lIGtub3cgaWYgSSBuZWVkIHRvIHJlc3VibWl0IHRoaXMgcGF0Y2g/DQo+ID4g
DQo+ID4gSXQgc2VlbXMgdGhhdCB0aGUgY29tbWl0IGlzIG1lcmdlZCBidXQgd2l0aG91dCBpdHMg
Y29udGVudDoNCj4gPiAgICAgaHR0cHM6Ly9naXQuZHBkay5vcmcvZHBkay9jb21taXQvP2lkPTJh
YTdlMjhiNDENCj4gPiANCj4gPiBJdCBsb29rcyBsaWtlIGEgbWlzdGFrZSBkdXJpbmcgYSBuZXh0
LW5ldCByZWJhc2UuDQo+ID4gU3RlcGhlbiwgcGxlYXNlIHdvdWxkIHlvdSBiZSBhYmxlIHRvIGZp
bmQgdGhlIG9yaWdpbmFsIGNvbW1pdA0KPiA+IHRoYXQgeW91IG1vZGlmaWVkIGluIHlvdXIgcmVm
bG9nPw0KPiA+ICBPciBJIGNvdWxkIGdldCBpdCBmcm9tIHRoZSBtYWlsaW5nIGxpc3QgaWYgeW91
IGRpZG4ndCBjaGFuZ2UgaXQgdG9vIG11Y2guDQoNCj4gSSd2ZSBwdXNoZWQgYSBuZXcgY29tbWl0
IHdpdGggdGhlIGNvbnRlbnQgb2YgdGhlIHBhdGNoOg0KPiAgICBodHRwczovL2dpdC5kcGRrLm9y
Zy9kcGRrL2NvbW1pdC8/aWQ9YWY0MGE5M2ZhMjENCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3Ig
eW91ciByZXBseSBhbmQgZm9yIHB1c2hpbmcgYSBuZXcgY29tbWl0IHdpdGggdGhlIGNvbnRlbnQg
b2YgdGhlIHBhdGNoLg0KDQpJIG5vdGljZWQgdGhhdCBpdCBoYXMgYmVlbiBtZXJnZWQgaW50byB0
aGUgZHBkayByZXBvLCBhbmQgaSB3b3VsZCBsaWtlIHRvIGtub3cgaWYgaXQgd2lsbCBhbHNvIGJl
IG1lcmdlZCBpbnRvIHRoZSBuZXh0LW5ldCByZXBvLg0KSSBoYXZlIGJlZW4gc3VibWl0dGluZyBw
YXRjaGVzIHVzaW5nIHRoaXMgcmVwbywgYW5kIGkgcGxhbiB0byBzdWJtaXQgbmV3IHBhdGNoZXMg
dG8gdGhlIG5leHQtbmV0IHJlcG8uDQoNCkJlc3QgcmVnYXJkcy4=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Jmd0OyZuYnNwOyZndDsmbmJzcDsxOC8wMy8yMDI2Jm5ic3A7MDM6MjEsJm5ic3A7SnVubG9uZyZu
YnNwO1dhbmc6PGJyIC8+Jmd0OyZuYnNwOyZndDsmbmJzcDsmZ3Q7Jm5ic3A7U29ycnksJm5ic3A7
SSZuYnNwO2hhdmUmbmJzcDthJm5ic3A7cXVlc3Rpb24uPGJyIC8+Jmd0OyZuYnNwOyZndDsmbmJz
cDsmZ3Q7Jm5ic3A7U29tZSZuYnNwO3RpbWUmbmJzcDthZ28sJm5ic3A7SSZuYnNwO3N1Ym1pdHRl
ZCZuYnNwO3RoaXMmbmJzcDtwYXRjaCZuYnNwOyhbdjMsNS81XSZuYnNwO25ldC96eGRoOiZuYnNw
O2FkZCZuYnNwO3N1cHBvcnQmbmJzcDtmb3ImbmJzcDtHRU5FVkUmbmJzcDtUU08mbmJzcDthbmQm
bmJzcDtSeCZuYnNwO291dGVyJm5ic3A7Y2hlY2tzdW0pLDxiciAvPiZndDsmbmJzcDsmZ3Q7Jm5i
c3A7Jmd0OyZuYnNwO3doaWNoJm5ic3A7d2FzJm5ic3A7bWFya2VkJm5ic3A7YXMmbmJzcDthY2Nl
cHRlZC4mbmJzcDtIb3dldmVyLCZuYnNwO3doZW4mbmJzcDtJJm5ic3A7ZmV0Y2hlZCZuYnNwO3Ro
ZSZuYnNwO2xhdGVzdCZuYnNwO2RwZC1uZXh0LW5ldCZuYnNwO2NvZGUsJm5ic3A7dGhlJm5ic3A7
Zm9yLW1haW4mbmJzcDticmFuY2gmbmJzcDtkaWQmbmJzcDtub3QmbmJzcDtjb250YWluJm5ic3A7
aXQuPGJyIC8+Jmd0OyZuYnNwOyZndDsmbmJzcDsmZ3Q7Jm5ic3A7DTxiciAvPiZndDsmbmJzcDsm
Z3Q7Jm5ic3A7Jmd0OyZuYnNwO0NvdWxkJm5ic3A7eW91Jm5ic3A7cGxlYXNlJm5ic3A7bGV0Jm5i
c3A7bWUmbmJzcDtrbm93Jm5ic3A7aWYmbmJzcDtJJm5ic3A7bmVlZCZuYnNwO3RvJm5ic3A7cmVz
dWJtaXQmbmJzcDt0aGlzJm5ic3A7cGF0Y2g/PGJyIC8+Jmd0OyZuYnNwOyZndDsmbmJzcDsNPGJy
IC8+Jmd0OyZuYnNwOyZndDsmbmJzcDtJdCZuYnNwO3NlZW1zJm5ic3A7dGhhdCZuYnNwO3RoZSZu
YnNwO2NvbW1pdCZuYnNwO2lzJm5ic3A7bWVyZ2VkJm5ic3A7YnV0Jm5ic3A7d2l0aG91dCZuYnNw
O2l0cyZuYnNwO2NvbnRlbnQ6PGJyIC8+Jmd0OyZuYnNwOyZndDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDtodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL2NvbW1pdC8/aWQ9MmFhN2UyOGI0
MTxiciAvPiZndDsmbmJzcDsmZ3Q7Jm5ic3A7DTxiciAvPiZndDsmbmJzcDsmZ3Q7Jm5ic3A7SXQm
bmJzcDtsb29rcyZuYnNwO2xpa2UmbmJzcDthJm5ic3A7bWlzdGFrZSZuYnNwO2R1cmluZyZuYnNw
O2EmbmJzcDtuZXh0LW5ldCZuYnNwO3JlYmFzZS48YnIgLz4mZ3Q7Jm5ic3A7Jmd0OyZuYnNwO1N0
ZXBoZW4sJm5ic3A7cGxlYXNlJm5ic3A7d291bGQmbmJzcDt5b3UmbmJzcDtiZSZuYnNwO2FibGUm
bmJzcDt0byZuYnNwO2ZpbmQmbmJzcDt0aGUmbmJzcDtvcmlnaW5hbCZuYnNwO2NvbW1pdDxiciAv
PiZndDsmbmJzcDsmZ3Q7Jm5ic3A7dGhhdCZuYnNwO3lvdSZuYnNwO21vZGlmaWVkJm5ic3A7aW4m
bmJzcDt5b3VyJm5ic3A7cmVmbG9nPzxiciAvPiZndDsmbmJzcDsmZ3Q7Jm5ic3A7Jm5ic3A7T3Im
bmJzcDtJJm5ic3A7Y291bGQmbmJzcDtnZXQmbmJzcDtpdCZuYnNwO2Zyb20mbmJzcDt0aGUmbmJz
cDttYWlsaW5nJm5ic3A7bGlzdCZuYnNwO2lmJm5ic3A7eW91Jm5ic3A7ZGlkbiZhcG9zO3QmbmJz
cDtjaGFuZ2UmbmJzcDtpdCZuYnNwO3RvbyZuYnNwO211Y2guPGJyIC8+DTxiciAvPiZndDsmbmJz
cDtJJmFwb3M7dmUmbmJzcDtwdXNoZWQmbmJzcDthJm5ic3A7bmV3Jm5ic3A7Y29tbWl0Jm5ic3A7
d2l0aCZuYnNwO3RoZSZuYnNwO2NvbnRlbnQmbmJzcDtvZiZuYnNwO3RoZSZuYnNwO3BhdGNoOjxi
ciAvPiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtodHRwczovL2dpdC5kcGRrLm9yZy9kcGRr
L2NvbW1pdC8/aWQ9YWY0MGE5M2ZhMjE8YnIgLz4NPGJyIC8+VGhhbmsmbmJzcDt5b3UmbmJzcDt2
ZXJ5Jm5ic3A7bXVjaCZuYnNwO2ZvciZuYnNwO3lvdXImbmJzcDtyZXBseSZuYnNwO2FuZCZuYnNw
O2ZvciZuYnNwO3B1c2hpbmcmbmJzcDthJm5ic3A7bmV3Jm5ic3A7Y29tbWl0Jm5ic3A7d2l0aCZu
YnNwO3RoZSZuYnNwO2NvbnRlbnQmbmJzcDtvZiZuYnNwO3RoZSZuYnNwO3BhdGNoLjxiciAvPg08
YnIgLz5JJm5ic3A7bm90aWNlZCZuYnNwO3RoYXQmbmJzcDtpdCZuYnNwO2hhcyZuYnNwO2JlZW4m
bmJzcDttZXJnZWQmbmJzcDtpbnRvJm5ic3A7dGhlJm5ic3A7ZHBkayZuYnNwO3JlcG8sJm5ic3A7
YW5kJm5ic3A7aSZuYnNwO3dvdWxkJm5ic3A7bGlrZSZuYnNwO3RvJm5ic3A7a25vdyZuYnNwO2lm
Jm5ic3A7aXQmbmJzcDt3aWxsJm5ic3A7YWxzbyZuYnNwO2JlJm5ic3A7bWVyZ2VkJm5ic3A7aW50
byZuYnNwO3RoZSZuYnNwO25leHQtbmV0Jm5ic3A7cmVwby48YnIgLz5JJm5ic3A7aGF2ZSZuYnNw
O2JlZW4mbmJzcDtzdWJtaXR0aW5nJm5ic3A7cGF0Y2hlcyZuYnNwO3VzaW5nJm5ic3A7dGhpcyZu
YnNwO3JlcG8sJm5ic3A7YW5kJm5ic3A7aSZuYnNwO3BsYW4mbmJzcDt0byZuYnNwO3N1Ym1pdCZu
YnNwO25ldyZuYnNwO3BhdGNoZXMmbmJzcDt0byZuYnNwO3RoZSZuYnNwO25leHQtbmV0Jm5ic3A7
cmVwby48YnIgLz4NPGJyIC8+QmVzdCZuYnNwO3JlZ2FyZHMuPGJyIC8+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

