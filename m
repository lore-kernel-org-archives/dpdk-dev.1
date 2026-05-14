Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B779CCD37AC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 02:28:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E555040276;
	Thu, 14 May 2026 04:28:24 +0200 (CEST)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTP id 73AF44025E
 for <dev@dpdk.org>; Thu, 14 May 2026 04:28:23 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4gGDlR3mGdz51SXw;
 Thu, 14 May 2026 10:28:19 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 64E2S9iV023135;
 Thu, 14 May 2026 10:28:09 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 14 May 2026 10:28:10 +0800
X-Zmail-TransId: 3e816a053336002-23af8
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: thomas@monjalon.net, stephen@networkplumber.org
Cc: ran.ming@zte.com.cn, dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>
Subject: [PATCH v1 1/2] net/zxdh: add supported zxdh support nics
Date: Thu, 14 May 2026 09:56:49 +0800
Message-ID: <20260514015650.3500578-1-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 64E2S9iV023135
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 14 May 2026 10:28:19 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A053343.000/4gGDlR3mGdz51SXw
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

dXBkYXRlIHp4ZGggbmljcyBkb2MucnN0LCBhZGQgenhkaCBzdXBwb3J0IG5pY3MuDQoNClNpZ25l
ZC1vZmYtYnk6IEp1bmxvbmcgV2FuZyA8d2FuZy5qdW5sb25nMUB6dGUuY29tLmNuPg0KLS0tDQog
ZG9jL2d1aWRlcy9uaWNzL3p4ZGgucnN0IHwgMTAgKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kb2MvZ3Vp
ZGVzL25pY3MvenhkaC5yc3QgYi9kb2MvZ3VpZGVzL25pY3MvenhkaC5yc3QNCmluZGV4IGYxZGZl
YTg2YWIuLjRmOTZkNDQyMGIgMTAwNjQ0DQotLS0gYS9kb2MvZ3VpZGVzL25pY3MvenhkaC5yc3QN
CisrKyBiL2RvYy9ndWlkZXMvbmljcy96eGRoLnJzdA0KQEAgLTUsMTMgKzUsMTkgQEAgWlhESCBQ
b2xsIE1vZGUgRHJpdmVyDQogPT09PT09PT09PT09PT09PT09PT09DQogDQogVGhlIFpYREggUE1E
ICgqKmxpYnJ0ZV9uZXRfenhkaCoqKSBwcm92aWRlcyBwb2xsIG1vZGUgZHJpdmVyIHN1cHBvcnQN
Ci1mb3IgMjUvMTAwIEdicHMgWlhESCBOWCBTZXJpZXMgRXRoZXJuZXQgQ29udHJvbGxlcg0KLWJh
c2VkIG9uIHRoZSBaVEUgRXRoZXJuZXQgQ29udHJvbGxlciBFMzEwL0UzMTIuDQorZm9yIDI1LzEw
MC8yMDAgR2JwcyBaWERIIE5YIFNlcmllcyBFdGhlcm5ldCBDb250cm9sbGVyLg0KIA0KIE1vcmUg
aW5mb3JtYXRpb24gb24NCiBgWlhESCBOWCBTZXJpZXMgRXRoZXJuZXQgQ29udHJvbGxlciBOSUNz
DQogPGh0dHBzOi8vZW50ZXJwcmlzZS56dGUuY29tLmNuL3N1cC1kZXRhaWwuaHRtbD9pZD0yNzEm
c3VwdHlwZT0xPmBfLg0KIA0KK1N1cHBvcnRlZCBOSUNzDQorLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQorDQorLSBaWERIIEUzMTAgMjUgR2lnYWJpdCBFdGhlcm5ldCBDb250cm9sbGVyDQor
LSBaWERIIEUzMTIgMTAwIEdpZ2FiaXQgRXRoZXJuZXQgQ29udHJvbGxlcg0KKy0gWlhESCBFMzEy
UyAxMDAgR2lnYWJpdCBFdGhlcm5ldCBDb250cm9sbGVyDQorLSBaWERIIEUzMTYgMjAwIEdpZ2Fi
aXQgRXRoZXJuZXQgQ29udHJvbGxlcg0KIA0KIEZlYXR1cmVzDQogLS0tLS0tLS0NCi0tIA0KMi4y
Ny4w


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

dXBkYXRlJm5ic3A7enhkaCZuYnNwO25pY3MmbmJzcDtkb2MucnN0LCZuYnNwO2FkZCZuYnNwO3p4
ZGgmbmJzcDtzdXBwb3J0Jm5ic3A7bmljcy48YnIgLz4NPGJyIC8+U2lnbmVkLW9mZi1ieTombmJz
cDtKdW5sb25nJm5ic3A7V2FuZyZuYnNwOyZsdDt3YW5nLmp1bmxvbmcxQHp0ZS5jb20uY24mZ3Q7
DTxiciAvPi0tLTxiciAvPiZuYnNwO2RvYy9ndWlkZXMvbmljcy96eGRoLnJzdCZuYnNwO3wmbmJz
cDsxMCZuYnNwOysrKysrKysrLS08YnIgLz4mbmJzcDsxJm5ic3A7ZmlsZSZuYnNwO2NoYW5nZWQs
Jm5ic3A7OCZuYnNwO2luc2VydGlvbnMoKyksJm5ic3A7MiZuYnNwO2RlbGV0aW9ucygtKTxiciAv
Pg08YnIgLz5kaWZmJm5ic3A7LS1naXQmbmJzcDthL2RvYy9ndWlkZXMvbmljcy96eGRoLnJzdCZu
YnNwO2IvZG9jL2d1aWRlcy9uaWNzL3p4ZGgucnN0PGJyIC8+aW5kZXgmbmJzcDtmMWRmZWE4NmFi
Li40Zjk2ZDQ0MjBiJm5ic3A7MTAwNjQ0PGJyIC8+LS0tJm5ic3A7YS9kb2MvZ3VpZGVzL25pY3Mv
enhkaC5yc3Q8YnIgLz4rKysmbmJzcDtiL2RvYy9ndWlkZXMvbmljcy96eGRoLnJzdDxiciAvPkBA
Jm5ic3A7LTUsMTMmbmJzcDsrNSwxOSZuYnNwO0BAJm5ic3A7WlhESCZuYnNwO1BvbGwmbmJzcDtN
b2RlJm5ic3A7RHJpdmVyPGJyIC8+Jm5ic3A7PT09PT09PT09PT09PT09PT09PT09PGJyIC8+Jm5i
c3A7DTxiciAvPiZuYnNwO1RoZSZuYnNwO1pYREgmbmJzcDtQTUQmbmJzcDsoKipsaWJydGVfbmV0
X3p4ZGgqKikmbmJzcDtwcm92aWRlcyZuYnNwO3BvbGwmbmJzcDttb2RlJm5ic3A7ZHJpdmVyJm5i
c3A7c3VwcG9ydDxiciAvPi1mb3ImbmJzcDsyNS8xMDAmbmJzcDtHYnBzJm5ic3A7WlhESCZuYnNw
O05YJm5ic3A7U2VyaWVzJm5ic3A7RXRoZXJuZXQmbmJzcDtDb250cm9sbGVyPGJyIC8+LWJhc2Vk
Jm5ic3A7b24mbmJzcDt0aGUmbmJzcDtaVEUmbmJzcDtFdGhlcm5ldCZuYnNwO0NvbnRyb2xsZXIm
bmJzcDtFMzEwL0UzMTIuPGJyIC8+K2ZvciZuYnNwOzI1LzEwMC8yMDAmbmJzcDtHYnBzJm5ic3A7
WlhESCZuYnNwO05YJm5ic3A7U2VyaWVzJm5ic3A7RXRoZXJuZXQmbmJzcDtDb250cm9sbGVyLjxi
ciAvPiZuYnNwOw08YnIgLz4mbmJzcDtNb3JlJm5ic3A7aW5mb3JtYXRpb24mbmJzcDtvbjxiciAv
PiZuYnNwO2BaWERIJm5ic3A7TlgmbmJzcDtTZXJpZXMmbmJzcDtFdGhlcm5ldCZuYnNwO0NvbnRy
b2xsZXImbmJzcDtOSUNzPGJyIC8+Jm5ic3A7Jmx0O2h0dHBzOi8vZW50ZXJwcmlzZS56dGUuY29t
LmNuL3N1cC1kZXRhaWwuaHRtbD9pZD0yNzEmYW1wO3N1cHR5cGU9MSZndDtgXy48YnIgLz4mbmJz
cDsNPGJyIC8+K1N1cHBvcnRlZCZuYnNwO05JQ3M8YnIgLz4rLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPGJyIC8+KzxiciAvPistJm5ic3A7WlhESCZuYnNwO0UzMTAmbmJzcDsyNSZuYnNwO0dp
Z2FiaXQmbmJzcDtFdGhlcm5ldCZuYnNwO0NvbnRyb2xsZXI8YnIgLz4rLSZuYnNwO1pYREgmbmJz
cDtFMzEyJm5ic3A7MTAwJm5ic3A7R2lnYWJpdCZuYnNwO0V0aGVybmV0Jm5ic3A7Q29udHJvbGxl
cjxiciAvPistJm5ic3A7WlhESCZuYnNwO0UzMTJTJm5ic3A7MTAwJm5ic3A7R2lnYWJpdCZuYnNw
O0V0aGVybmV0Jm5ic3A7Q29udHJvbGxlcjxiciAvPistJm5ic3A7WlhESCZuYnNwO0UzMTYmbmJz
cDsyMDAmbmJzcDtHaWdhYml0Jm5ic3A7RXRoZXJuZXQmbmJzcDtDb250cm9sbGVyPGJyIC8+Jm5i
c3A7DTxiciAvPiZuYnNwO0ZlYXR1cmVzPGJyIC8+Jm5ic3A7LS0tLS0tLS08YnIgLz4tLSZuYnNw
Ow08YnIgLz4yLjI3LjA8YnIgLz4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

