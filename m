Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3C606D80B
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 03:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A80842E87;
	Sat,  7 Nov 2026 04:16:10 +0100 (CET)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
 by mails.dpdk.org (Postfix) with ESMTPS id 26A2142E66;
 Sat,  7 Nov 2026 04:16:09 +0100 (CET)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4jM1Qs38qdz55y2J;
 Sat, 07 Nov 2026 11:16:05 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl1.zte.com.cn with SMTP id 6A73Fog9019099;
 Sat, 7 Nov 2026 11:15:50 +0800 (+08)
 (envelope-from wang.junlong1@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Sat, 7 Nov 2026 11:15:51 +0800
X-Zmail-TransId: 3e816aee97e702a-ce9d0
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: wang.junlong1@zte.com.cn
From: Junlong Wang <wang.junlong1@zte.com.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Junlong Wang <wang.junlong1@zte.com.cn>, stable@dpdk.org
Subject: [PATCH v1 8/8] net/zxdh: check msg id before indexing the seqid table
Date: Sat,  7 Nov 2026 11:04:48 +0800
Message-ID: <20261107030448.2891345-9-wang.junlong1@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
References: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 6A73Fog9019099
X-TLS: YES
X-ENVELOPE-SENDER: wang.junlong1@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 11:16:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEE97F5.000/4jM1Qs38qdz55y2J
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



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

enhkaF9iYXJfbXNnX2Fja19hc3luY19tc2dfcHJvYygpIGluZGV4ZXMgdGhlIDI1Ni1lbnRyeQ0K
Z19zZXFpZF9yaW5nLnJlcHNfaW5mb190YmxbXSB3aXRoIHRoZSAxNi1iaXQgbXNnX2lkIHRha2Vu
IHN0cmFpZ2h0DQpmcm9tIHRoZSBtZXNzYWdlIGhlYWRlciBhIFZGIHdyaXRlcyBpbnRvIHRoZSBQ
Ri9WRiB3aW5kb3cuIE5vdGhpbmcgb24NCnRoZSByZWNlaXZlIHBhdGggY29tcGFyZXMgaXQgd2l0
aCBaWERIX0JBUl9TRVFJRF9OVU1fTUFYLCBzbyBhIGZvcmdlZA0KYXN5bmNocm9ub3VzIGFjayB3
aXRoIGFuIG91dC1vZi1yYW5nZSBtc2dfaWQgbWFrZXMgdGhlIFBGIHJlYWQsIGFuZA0KdW5kZXIg
c29tZSBjb25kaXRpb25zIHdyaXRlLCB1cCB0byAxIE1pQiBwYXN0IHRoZSB0YWJsZSwgY3Jhc2hp
bmcgdGhlDQpwcm9jZXNzIHRoYXQgZHJpdmVzIHRoZSBQRi4NCg0KUmVqZWN0IG1zZ19pZCA+PSBa
WERIX0JBUl9TRVFJRF9OVU1fTUFYIGJlZm9yZSB0aGUgc2xvdCBwb2ludGVyIGlzDQpmb3JtZWQ6
IHRoZSBpZCBpcyBsb2dnZWQgYXMgaW52YWxpZCBhbmQgdGhlIG1lc3NhZ2UgZHJvcHBlZCwgbGlr
ZSBhbg0KaWQgdGhhdCBpcyBhbHJlYWR5IHJlbGVhc2VkLiBUaGUgZHJpdmVyIG9ubHkgZXZlciBh
bGxvY2F0ZXMgaWRzIGJlbG93DQoyNTYsIHNvIGEgd2VsbC1mb3JtZWQgcGVlciBpcyB1bmFmZmVj
dGVkLg0KDQpBcHBseSB0aGUgc2FtZSBjb21wYXJpc29uIGluIHp4ZGhfYmFyX2NoYW5fc3luY19t
c2dfcmVwc19nZXQoKSwgd2hpY2gNCmluZGV4ZXMgdGhlIHNhbWUgdGFibGUgd2l0aCB0aGUgbXNn
X2lkIG9mIGEgcmVwbHk7IHRoYXQgcGF0aCBpcyBub3QNCnJlYWNoYWJsZSBmcm9tIGEgVkYgdG9k
YXksIHRoZSBjaGVjayBpcyBoYXJkZW5pbmcuDQoNCkZpeGVzOiAzNjMwYWM4YmQ4MWYgKCJuZXQv
enhkaDogY29uZmlndXJlIGludGVycnVwdCIpDQpDYzogc3RhYmxlQGRwZGsub3JnDQoNClNpZ25l
ZC1vZmYtYnk6IEp1bmxvbmcgV2FuZyA8d2FuZy5qdW5sb25nMUB6dGUuY29tLmNuPg0KLS0tDQog
ZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5jIHwgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cu
YyBiL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuYw0KaW5kZXggNzdiOGRmMmYxMi4uNWU0MDg1
ZTRmYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuYw0KKysrIGIvZHJp
dmVycy9uZXQvenhkaC96eGRoX21zZy5jDQpAQCAtNzAzLDYgKzcwMywxMSBAQCB6eGRoX2Jhcl9j
aGFuX3N5bmNfbXNnX3JlcHNfZ2V0KHVpbnQ2NF90IHN1YmNoYW5fYWRkciwNCiANCiAJenhkaF9i
YXJfY2hhbl9tc2dfaGVhZGVyX2dldChzdWJjaGFuX2FkZHIsICZtc2dfaGVhZGVyKTsNCiAJbXNn
X2lkID0gbXNnX2hlYWRlci5tc2dfaWQ7DQorCWlmIChtc2dfaWQgPj0gWlhESF9CQVJfU0VRSURf
TlVNX01BWCkgew0KKwkJUE1EX01TR19MT0coRVJSLCAibXNnX2lkICV1IGlzIGludmFsaWQiLCBt
c2dfaWQpOw0KKwkJcmV0dXJuIFpYREhfQkFSX01TR19FUlJfUkVQTFk7DQorCX0NCisNCiAJc3Ry
dWN0IHp4ZGhfc2VxaWRfaXRlbSAqcmVwc19pbmZvID0gJmdfc2VxaWRfcmluZy5yZXBzX2luZm9f
dGJsW21zZ19pZF07DQogDQogCWlmIChyZXBzX2luZm8tPmZsYWcgIT0gWlhESF9SRVBTX0lORk9f
RkxBR19VU0VEKSB7DQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

enhkaF9iYXJfbXNnX2Fja19hc3luY19tc2dfcHJvYygpJm5ic3A7aW5kZXhlcyZuYnNwO3RoZSZu
YnNwOzI1Ni1lbnRyeTxiciAvPmdfc2VxaWRfcmluZy5yZXBzX2luZm9fdGJsW10mbmJzcDt3aXRo
Jm5ic3A7dGhlJm5ic3A7MTYtYml0Jm5ic3A7bXNnX2lkJm5ic3A7dGFrZW4mbmJzcDtzdHJhaWdo
dDxiciAvPmZyb20mbmJzcDt0aGUmbmJzcDttZXNzYWdlJm5ic3A7aGVhZGVyJm5ic3A7YSZuYnNw
O1ZGJm5ic3A7d3JpdGVzJm5ic3A7aW50byZuYnNwO3RoZSZuYnNwO1BGL1ZGJm5ic3A7d2luZG93
LiZuYnNwO05vdGhpbmcmbmJzcDtvbjxiciAvPnRoZSZuYnNwO3JlY2VpdmUmbmJzcDtwYXRoJm5i
c3A7Y29tcGFyZXMmbmJzcDtpdCZuYnNwO3dpdGgmbmJzcDtaWERIX0JBUl9TRVFJRF9OVU1fTUFY
LCZuYnNwO3NvJm5ic3A7YSZuYnNwO2ZvcmdlZDxiciAvPmFzeW5jaHJvbm91cyZuYnNwO2FjayZu
YnNwO3dpdGgmbmJzcDthbiZuYnNwO291dC1vZi1yYW5nZSZuYnNwO21zZ19pZCZuYnNwO21ha2Vz
Jm5ic3A7dGhlJm5ic3A7UEYmbmJzcDtyZWFkLCZuYnNwO2FuZDxiciAvPnVuZGVyJm5ic3A7c29t
ZSZuYnNwO2NvbmRpdGlvbnMmbmJzcDt3cml0ZSwmbmJzcDt1cCZuYnNwO3RvJm5ic3A7MSZuYnNw
O01pQiZuYnNwO3Bhc3QmbmJzcDt0aGUmbmJzcDt0YWJsZSwmbmJzcDtjcmFzaGluZyZuYnNwO3Ro
ZTxiciAvPnByb2Nlc3MmbmJzcDt0aGF0Jm5ic3A7ZHJpdmVzJm5ic3A7dGhlJm5ic3A7UEYuPGJy
IC8+DTxiciAvPlJlamVjdCZuYnNwO21zZ19pZCZuYnNwOyZndDs9Jm5ic3A7WlhESF9CQVJfU0VR
SURfTlVNX01BWCZuYnNwO2JlZm9yZSZuYnNwO3RoZSZuYnNwO3Nsb3QmbmJzcDtwb2ludGVyJm5i
c3A7aXM8YnIgLz5mb3JtZWQ6Jm5ic3A7dGhlJm5ic3A7aWQmbmJzcDtpcyZuYnNwO2xvZ2dlZCZu
YnNwO2FzJm5ic3A7aW52YWxpZCZuYnNwO2FuZCZuYnNwO3RoZSZuYnNwO21lc3NhZ2UmbmJzcDtk
cm9wcGVkLCZuYnNwO2xpa2UmbmJzcDthbjxiciAvPmlkJm5ic3A7dGhhdCZuYnNwO2lzJm5ic3A7
YWxyZWFkeSZuYnNwO3JlbGVhc2VkLiZuYnNwO1RoZSZuYnNwO2RyaXZlciZuYnNwO29ubHkmbmJz
cDtldmVyJm5ic3A7YWxsb2NhdGVzJm5ic3A7aWRzJm5ic3A7YmVsb3c8YnIgLz4yNTYsJm5ic3A7
c28mbmJzcDthJm5ic3A7d2VsbC1mb3JtZWQmbmJzcDtwZWVyJm5ic3A7aXMmbmJzcDt1bmFmZmVj
dGVkLjxiciAvPg08YnIgLz5BcHBseSZuYnNwO3RoZSZuYnNwO3NhbWUmbmJzcDtjb21wYXJpc29u
Jm5ic3A7aW4mbmJzcDt6eGRoX2Jhcl9jaGFuX3N5bmNfbXNnX3JlcHNfZ2V0KCksJm5ic3A7d2hp
Y2g8YnIgLz5pbmRleGVzJm5ic3A7dGhlJm5ic3A7c2FtZSZuYnNwO3RhYmxlJm5ic3A7d2l0aCZu
YnNwO3RoZSZuYnNwO21zZ19pZCZuYnNwO29mJm5ic3A7YSZuYnNwO3JlcGx5OyZuYnNwO3RoYXQm
bmJzcDtwYXRoJm5ic3A7aXMmbmJzcDtub3Q8YnIgLz5yZWFjaGFibGUmbmJzcDtmcm9tJm5ic3A7
YSZuYnNwO1ZGJm5ic3A7dG9kYXksJm5ic3A7dGhlJm5ic3A7Y2hlY2smbmJzcDtpcyZuYnNwO2hh
cmRlbmluZy48YnIgLz4NPGJyIC8+Rml4ZXM6Jm5ic3A7MzYzMGFjOGJkODFmJm5ic3A7KCZxdW90
O25ldC96eGRoOiZuYnNwO2NvbmZpZ3VyZSZuYnNwO2ludGVycnVwdCZxdW90Oyk8YnIgLz5DYzom
bmJzcDtzdGFibGVAZHBkay5vcmc8YnIgLz4NPGJyIC8+U2lnbmVkLW9mZi1ieTombmJzcDtKdW5s
b25nJm5ic3A7V2FuZyZuYnNwOyZsdDt3YW5nLmp1bmxvbmcxQHp0ZS5jb20uY24mZ3Q7DTxiciAv
Pi0tLTxiciAvPiZuYnNwO2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cuYyZuYnNwO3wmbmJzcDs1
Jm5ic3A7KysrKys8YnIgLz4mbmJzcDsxJm5ic3A7ZmlsZSZuYnNwO2NoYW5nZWQsJm5ic3A7NSZu
YnNwO2luc2VydGlvbnMoKyk8YnIgLz4NPGJyIC8+ZGlmZiZuYnNwOy0tZ2l0Jm5ic3A7YS9kcml2
ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmMmbmJzcDtiL2RyaXZlcnMvbmV0L3p4ZGgvenhkaF9tc2cu
YzxiciAvPmluZGV4Jm5ic3A7NzdiOGRmMmYxMi4uNWU0MDg1ZTRmYSZuYnNwOzEwMDY0NDxiciAv
Pi0tLSZuYnNwO2EvZHJpdmVycy9uZXQvenhkaC96eGRoX21zZy5jPGJyIC8+KysrJm5ic3A7Yi9k
cml2ZXJzL25ldC96eGRoL3p4ZGhfbXNnLmM8YnIgLz5AQCZuYnNwOy03MDMsNiZuYnNwOys3MDMs
MTEmbmJzcDtAQCZuYnNwO3p4ZGhfYmFyX2NoYW5fc3luY19tc2dfcmVwc19nZXQodWludDY0X3Qm
bmJzcDtzdWJjaGFuX2FkZHIsPGJyIC8+Jm5ic3A7DTxiciAvPiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3p4ZGhfYmFyX2NoYW5fbXNnX2hlYWRlcl9nZXQoc3ViY2hhbl9hZGRyLCZuYnNw
OyZhbXA7bXNnX2hlYWRlcik7PGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7bXNn
X2lkJm5ic3A7PSZuYnNwO21zZ19oZWFkZXIubXNnX2lkOzxiciAvPismbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDtpZiZuYnNwOyhtc2dfaWQmbmJzcDsmZ3Q7PSZuYnNwO1pYREhfQkFSX1NFUUlEX05V
TV9NQVgpJm5ic3A7ezxiciAvPismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDtQTURfTVNHX0xPRyhFUlIsJm5ic3A7JnF1b3Q7bXNnX2lkJm5ic3A7JXUmbmJz
cDtpcyZuYnNwO2ludmFsaWQmcXVvdDssJm5ic3A7bXNnX2lkKTs8YnIgLz4rJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7cmV0dXJuJm5ic3A7WlhESF9CQVJf
TVNHX0VSUl9SRVBMWTs8YnIgLz4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7fTxiciAvPis8YnIg
Lz4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtzdHJ1Y3QmbmJzcDt6eGRoX3NlcWlkX2l0
ZW0mbmJzcDsqcmVwc19pbmZvJm5ic3A7PSZuYnNwOyZhbXA7Z19zZXFpZF9yaW5nLnJlcHNfaW5m
b190YmxbbXNnX2lkXTs8YnIgLz4mbmJzcDsNPGJyIC8+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7aWYmbmJzcDsocmVwc19pbmZvLSZndDtmbGFnJm5ic3A7IT0mbmJzcDtaWERIX1JFUFNf
SU5GT19GTEFHX1VTRUQpJm5ic3A7ezxiciAvPi0tJm5ic3A7DTxiciAvPjIuMjcuMDxiciAvPg==

--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

