Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE80C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 10:57:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F973402A7;
	Tue, 12 Aug 2025 12:57:21 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id 5FB244026A
 for <dev@dpdk.org>; Tue, 12 Aug 2025 12:57:19 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4c1T3c3jX8z6FyBs;
 Tue, 12 Aug 2025 18:57:16 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl1.zte.com.cn with SMTP id 57CAv1sG021069;
 Tue, 12 Aug 2025 18:57:01 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Tue, 12 Aug 2025 18:57:04 +0800
X-Zmail-TransId: 3e81689b1dfc001-b9bac
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: ivan.malov@arknetworks.am, stephen@networkplumber.org
Cc: chen.bingbin@zte.com.cn, dev@dpdk.org
Subject: [v4,2/2] net/zxdh: add support flow director ops
Date: Tue, 12 Aug 2025 18:47:03 +0800
Message-ID: <20250812104703.2111951-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808071048.1906724-3-wang.junlong1@zte.com.cn>
References: <20250808071048.1906724-3-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 57CAv1sG021069
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 12 Aug 2025 18:57:16 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 689B1E0C.000/4c1T3c3jX8z6FyBs
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

PiA+ID4gV2FpdCBhIG1pbnV0ZS4uIGRvZXMgdGhpcyBtZWFuIHRoYXQgaWYgdGhlIHVzZXIgcGFz
c2VzLCBzYXksIEVUSCAvIElQVjQgLyBVRFANCj4gPiA+IHBhdHRlcm4gYW5kIHRoZSAnc3BlYycg
YW5kICdtYXNrJyBvZiBFVEggYXJlIGJvdGggJ251bGwnLCB0aGUgYWN0dWFsIGtleS9tYXNrDQo+
ID4gPiB2YWx1ZXMgaW4gdGhlIEhXIHJ1bGUgd2lsbCBiZSwgc2F5LCBmb3IgdGhlIEV0aGVyVHlw
ZSwgJzAwMDAnIGFuZCAnZmZmZic/DQo+ID4gPiBJcyB0aGlzIGNvcnJlY3Q/IEFuZCB3aGljaCBw
YXJ0IG9mIERQREsgaW50ZXJmYWNlIGVudmlzYWdlcyB0aGF0Pw0KPiA+IA0KPiA+ID4gQWdhaW4s
IG1heSBiZSBpdCdzIGp1c3QgbXkgbWlzdW5kZXJzdGFuZGluZy4NCj4gPiANCj4gPiAgU29ycnks
IEkgbWlzdW5kZXJzdG9vZCBhbmQgY2F1c2VkIHlvdSBpbmNvbnZlbmllbmNlLg0KPiA+ICBJZiB0
aGUgdXNlciBkb2VzIG5vdCBzZXQgJ3NwZWMnIGFuZCAnbWFzaycsIHdlIHdpbGwgc2V0ICdzcGVj
JyAnMDAwMCcgYW5kIG1hc2sgJ2ZmZmYnIHdyaXRlIGZkIHRhYmxlIHRvIEhXLA0KPiA+ICBub3Qg
c2V0IGJ5IERQREsgaW50ZXJmYWNlLg0KPiA+ICBJZiB0aGUgdXNlciBzZXQgb25lIG9mICdzcGVj
JyBhbmQgJ21hc2snLCB3ZSB3aWxsIGFsc28gc2V0ICdzcGVjJyAnMDAwMCcgYW5kIG1hc2sgJ2Zm
ZmYnIHdyaXRlIGZkIHRhYmxlIHRvIEhXLg0KPiA+ICBUaGlzIGlzIGhvdyB3ZSBoYW5kbGUgaXQu
DQoNCj4gVW5kZXJzdG9vZC4gQnV0IGlzIHRoaXMgdGhlIGJlc3QgY291cnNlIG9mIGFjdGlvbj8g
U2F5LCB3aGF0IGhhcHBlbnMgaWYgdGhlIHVzZXINCj4gcGFzc2VzIEVUSCAvIElQVjQgLyBVRFAg
cGF0dGVybiBpdGVtcywgd2hlcmUgJ3NwZWMnIGFuZCAnbWFzaycgYXJlICdudWxsJyBpbiBhbGwN
Cj4gdGhlIGl0ZW1zPyBUaGVvcmV0aWNhbGx5LCB0aGUgZHJpdmVyIGNvdWxkIHRyYW5zbGF0ZSB0
aGlzIHRvIHNldCB0aGUga2V5IHRvIGhhdmUNCj4gRXRoZXJUeXBlIDB4MDgwMC8weGZmZmYgYW5k
IElQIHByb3RvY29sIHRvIGJlIDB4MTEvMHhmZiAuIE9yIGFtIEkgd3Jvbmc/DQoNCj4gVGhhbmsg
eW91Lg0KDQogWWVzLCB5b3UgYXJlIHJpZ2h0LiBDdXJyZW50bHksIG91ciBwbGFuIGlzIG5vdCBv
cHRpbWFsLCBhbmQgd2Ugd2lsbCB0YWtlIHlvdXIgc3VnZ2VzdGlvbnMgYXMgYSByZWZlcmVuY2Uu
DQogSWYgdGhlcmUgYXJlIGFueSBvcHRpbWl6YXRpb25zIGluIHRoZSBmdXR1cmUsIHdlIHdpbGwg
cmVzdWJtaXQgaXQuDQoNCiBUaGFuayB5b3UgdmVyeSBtdWNoLg==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Jmd0OyZuYnNwOyZndDsmbmJzcDsmZ3Q7Jm5ic3A7V2FpdCZuYnNwO2EmbmJzcDttaW51dGUuLiZu
YnNwO2RvZXMmbmJzcDt0aGlzJm5ic3A7bWVhbiZuYnNwO3RoYXQmbmJzcDtpZiZuYnNwO3RoZSZu
YnNwO3VzZXImbmJzcDtwYXNzZXMsJm5ic3A7c2F5LCZuYnNwO0VUSCZuYnNwOy8mbmJzcDtJUFY0
Jm5ic3A7LyZuYnNwO1VEUDxiciAvPiZndDsmbmJzcDsmZ3Q7Jm5ic3A7Jmd0OyZuYnNwO3BhdHRl
cm4mbmJzcDthbmQmbmJzcDt0aGUmbmJzcDsmYXBvcztzcGVjJmFwb3M7Jm5ic3A7YW5kJm5ic3A7
JmFwb3M7bWFzayZhcG9zOyZuYnNwO29mJm5ic3A7RVRIJm5ic3A7YXJlJm5ic3A7Ym90aCZuYnNw
OyZhcG9zO251bGwmYXBvczssJm5ic3A7dGhlJm5ic3A7YWN0dWFsJm5ic3A7a2V5L21hc2s8YnIg
Lz4mZ3Q7Jm5ic3A7Jmd0OyZuYnNwOyZndDsmbmJzcDt2YWx1ZXMmbmJzcDtpbiZuYnNwO3RoZSZu
YnNwO0hXJm5ic3A7cnVsZSZuYnNwO3dpbGwmbmJzcDtiZSwmbmJzcDtzYXksJm5ic3A7Zm9yJm5i
c3A7dGhlJm5ic3A7RXRoZXJUeXBlLCZuYnNwOyZhcG9zOzAwMDAmYXBvczsmbmJzcDthbmQmbmJz
cDsmYXBvcztmZmZmJmFwb3M7PzxiciAvPiZndDsmbmJzcDsmZ3Q7Jm5ic3A7Jmd0OyZuYnNwO0lz
Jm5ic3A7dGhpcyZuYnNwO2NvcnJlY3Q/Jm5ic3A7QW5kJm5ic3A7d2hpY2gmbmJzcDtwYXJ0Jm5i
c3A7b2YmbmJzcDtEUERLJm5ic3A7aW50ZXJmYWNlJm5ic3A7ZW52aXNhZ2VzJm5ic3A7dGhhdD88
YnIgLz4mZ3Q7Jm5ic3A7Jmd0OyZuYnNwOw08YnIgLz4mZ3Q7Jm5ic3A7Jmd0OyZuYnNwOyZndDsm
bmJzcDtBZ2FpbiwmbmJzcDttYXkmbmJzcDtiZSZuYnNwO2l0JmFwb3M7cyZuYnNwO2p1c3QmbmJz
cDtteSZuYnNwO21pc3VuZGVyc3RhbmRpbmcuPGJyIC8+Jmd0OyZuYnNwOyZndDsmbmJzcDsNPGJy
IC8+Jmd0OyZuYnNwOyZndDsmbmJzcDsmbmJzcDtTb3JyeSwmbmJzcDtJJm5ic3A7bWlzdW5kZXJz
dG9vZCZuYnNwO2FuZCZuYnNwO2NhdXNlZCZuYnNwO3lvdSZuYnNwO2luY29udmVuaWVuY2UuPGJy
IC8+Jmd0OyZuYnNwOyZndDsmbmJzcDsmbmJzcDtJZiZuYnNwO3RoZSZuYnNwO3VzZXImbmJzcDtk
b2VzJm5ic3A7bm90Jm5ic3A7c2V0Jm5ic3A7JmFwb3M7c3BlYyZhcG9zOyZuYnNwO2FuZCZuYnNw
OyZhcG9zO21hc2smYXBvczssJm5ic3A7d2UmbmJzcDt3aWxsJm5ic3A7c2V0Jm5ic3A7JmFwb3M7
c3BlYyZhcG9zOyZuYnNwOyZhcG9zOzAwMDAmYXBvczsmbmJzcDthbmQmbmJzcDttYXNrJm5ic3A7
JmFwb3M7ZmZmZiZhcG9zOyZuYnNwO3dyaXRlJm5ic3A7ZmQmbmJzcDt0YWJsZSZuYnNwO3RvJm5i
c3A7SFcsPGJyIC8+Jmd0OyZuYnNwOyZndDsmbmJzcDsmbmJzcDtub3QmbmJzcDtzZXQmbmJzcDti
eSZuYnNwO0RQREsmbmJzcDtpbnRlcmZhY2UuPGJyIC8+Jmd0OyZuYnNwOyZndDsmbmJzcDsmbmJz
cDtJZiZuYnNwO3RoZSZuYnNwO3VzZXImbmJzcDtzZXQmbmJzcDtvbmUmbmJzcDtvZiZuYnNwOyZh
cG9zO3NwZWMmYXBvczsmbmJzcDthbmQmbmJzcDsmYXBvczttYXNrJmFwb3M7LCZuYnNwO3dlJm5i
c3A7d2lsbCZuYnNwO2Fsc28mbmJzcDtzZXQmbmJzcDsmYXBvcztzcGVjJmFwb3M7Jm5ic3A7JmFw
b3M7MDAwMCZhcG9zOyZuYnNwO2FuZCZuYnNwO21hc2smbmJzcDsmYXBvcztmZmZmJmFwb3M7Jm5i
c3A7d3JpdGUmbmJzcDtmZCZuYnNwO3RhYmxlJm5ic3A7dG8mbmJzcDtIVy48YnIgLz4mZ3Q7Jm5i
c3A7Jmd0OyZuYnNwOyZuYnNwO1RoaXMmbmJzcDtpcyZuYnNwO2hvdyZuYnNwO3dlJm5ic3A7aGFu
ZGxlJm5ic3A7aXQuPGJyIC8+DTxiciAvPiZndDsmbmJzcDtVbmRlcnN0b29kLiZuYnNwO0J1dCZu
YnNwO2lzJm5ic3A7dGhpcyZuYnNwO3RoZSZuYnNwO2Jlc3QmbmJzcDtjb3Vyc2UmbmJzcDtvZiZu
YnNwO2FjdGlvbj8mbmJzcDtTYXksJm5ic3A7d2hhdCZuYnNwO2hhcHBlbnMmbmJzcDtpZiZuYnNw
O3RoZSZuYnNwO3VzZXI8YnIgLz4mZ3Q7Jm5ic3A7cGFzc2VzJm5ic3A7RVRIJm5ic3A7LyZuYnNw
O0lQVjQmbmJzcDsvJm5ic3A7VURQJm5ic3A7cGF0dGVybiZuYnNwO2l0ZW1zLCZuYnNwO3doZXJl
Jm5ic3A7JmFwb3M7c3BlYyZhcG9zOyZuYnNwO2FuZCZuYnNwOyZhcG9zO21hc2smYXBvczsmbmJz
cDthcmUmbmJzcDsmYXBvcztudWxsJmFwb3M7Jm5ic3A7aW4mbmJzcDthbGw8YnIgLz4mZ3Q7Jm5i
c3A7dGhlJm5ic3A7aXRlbXM/Jm5ic3A7VGhlb3JldGljYWxseSwmbmJzcDt0aGUmbmJzcDtkcml2
ZXImbmJzcDtjb3VsZCZuYnNwO3RyYW5zbGF0ZSZuYnNwO3RoaXMmbmJzcDt0byZuYnNwO3NldCZu
YnNwO3RoZSZuYnNwO2tleSZuYnNwO3RvJm5ic3A7aGF2ZTxiciAvPiZndDsmbmJzcDtFdGhlclR5
cGUmbmJzcDsweDA4MDAvMHhmZmZmJm5ic3A7YW5kJm5ic3A7SVAmbmJzcDtwcm90b2NvbCZuYnNw
O3RvJm5ic3A7YmUmbmJzcDsweDExLzB4ZmYmbmJzcDsuJm5ic3A7T3ImbmJzcDthbSZuYnNwO0km
bmJzcDt3cm9uZz88YnIgLz4NPGJyIC8+Jmd0OyZuYnNwO1RoYW5rJm5ic3A7eW91LjxiciAvPg08
YnIgLz4mbmJzcDtZZXMsJm5ic3A7eW91Jm5ic3A7YXJlJm5ic3A7cmlnaHQuJm5ic3A7Q3VycmVu
dGx5LCZuYnNwO291ciZuYnNwO3BsYW4mbmJzcDtpcyZuYnNwO25vdCZuYnNwO29wdGltYWwsJm5i
c3A7YW5kJm5ic3A7d2UmbmJzcDt3aWxsJm5ic3A7dGFrZSZuYnNwO3lvdXImbmJzcDtzdWdnZXN0
aW9ucyZuYnNwO2FzJm5ic3A7YSZuYnNwO3JlZmVyZW5jZS48YnIgLz4mbmJzcDtJZiZuYnNwO3Ro
ZXJlJm5ic3A7YXJlJm5ic3A7YW55Jm5ic3A7b3B0aW1pemF0aW9ucyZuYnNwO2luJm5ic3A7dGhl
Jm5ic3A7ZnV0dXJlLCZuYnNwO3dlJm5ic3A7d2lsbCZuYnNwO3Jlc3VibWl0Jm5ic3A7aXQuPGJy
IC8+DTxiciAvPiZuYnNwO1RoYW5rJm5ic3A7eW91Jm5ic3A7dmVyeSZuYnNwO211Y2guPGJyIC8+

--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

