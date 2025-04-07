Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC235C36002
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 01:43:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C9F040156;
	Mon,  7 Apr 2025 03:43:49 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
 by mails.dpdk.org (Postfix) with ESMTP id C367540150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 03:43:47 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZWBnY17Dwz5B1H0;
 Mon,  7 Apr 2025 09:43:45 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl2.zte.com.cn with SMTP id 5371hYPX072148;
 Mon, 7 Apr 2025 09:43:34 +0800 (+08)
 (envelope-from li.hanxiao@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Mon, 7 Apr 2025 09:43:35 +0800
X-Zmail-TransId: 3e8167f32dc1001-5026a
From: Hanxiao Li <li.hanxiao@zte.com.cn>
To: dev@dpdk.org
Cc: gakhil@marvell.com
Subject: Re: [v2,1/9] crypto/zsda: add skeleton
Date: Mon,  7 Apr 2025 09:43:25 +0800
Message-ID: <20250407014325.34266-1-li.hanxiao@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303082751.1053432-2-li.hanxiao@zte.com.cn>
References: <20250303082751.1053432-2-li.hanxiao@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 5371hYPX072148
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67F32DD1.000/4ZWBnY17Dwz5B1H0
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

SGkgQWtoaWwsDQoNClRoZSBuZXcgcGF0Y2hlcywgd2hpY2ggYXJlIHJlbGF0ZWQgdG8gY3J5cHRv
IGRyaXZlciBvZiB6c2RhIGRldmljZXMsIGhhdmUgYmVlbiBzdWJtaXQgZm9yIGEgbW9udGguDQoN
CkFsdGhvdWdoIHRoZXJlIGFyZSB0d28gZXJyb3JzIGhlcmUsIHRoZXkgYXJlIG5vdCBwcm9ibGVt
IGFib3V0IHRoZSBjb2RlLg0KV2hhdCdzIG1vcmUsIGluIG15IG9waW5pb24sIHRoZSBwYXRjaGVz
IHdvdWxkbid0IGhhdmUgbG90cyBvZiBlcnJvcnMgd2hpY2ggbmVlZCB0byBiZSBtb2RpZmllZC4N
CkJlY2F1c2UsIG1hbnkgc3VnZ2VzdGlvbnMgbWFkZSBpbiBwcmV2aW91cyBzdWJtaXR0aW5nIHBy
b2Nlc3Mgb2YgY29tcHJlc3Npb24gcGF0Y2hlcw0KaGF2ZSBiZWVuIGFkb3B0ZWQgaW4gdGhlIHBh
dGNoZXMgdGhpcyB0aW1lLg0KDQpJIHdpbGwgbW9kaWZ5IHRoZSByZWxlYXNlIG5vdGUgYW5kIHlv
dXJ0IHN1Z2dlc3Rpb25zIGluIHRoZSBuZXh0IHZlcnNvbi4NCg0KSSBhbSBoYXBweSB0byBoZWFy
IGZyb20geW91Lg==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGkmbmJzcDtBa2hpbCw8YnIgLz4NPGJyIC8+VGhlJm5ic3A7bmV3Jm5ic3A7cGF0Y2hlcywmbmJz
cDt3aGljaCZuYnNwO2FyZSZuYnNwO3JlbGF0ZWQmbmJzcDt0byZuYnNwO2NyeXB0byZuYnNwO2Ry
aXZlciZuYnNwO29mJm5ic3A7enNkYSZuYnNwO2RldmljZXMsJm5ic3A7aGF2ZSZuYnNwO2JlZW4m
bmJzcDtzdWJtaXQmbmJzcDtmb3ImbmJzcDthJm5ic3A7bW9udGguPGJyIC8+DTxiciAvPkFsdGhv
dWdoJm5ic3A7dGhlcmUmbmJzcDthcmUmbmJzcDt0d28mbmJzcDtlcnJvcnMmbmJzcDtoZXJlLCZu
YnNwO3RoZXkmbmJzcDthcmUmbmJzcDtub3QmbmJzcDtwcm9ibGVtJm5ic3A7YWJvdXQmbmJzcDt0
aGUmbmJzcDtjb2RlLjxiciAvPldoYXQmYXBvcztzJm5ic3A7bW9yZSwmbmJzcDtpbiZuYnNwO215
Jm5ic3A7b3BpbmlvbiwmbmJzcDt0aGUmbmJzcDtwYXRjaGVzJm5ic3A7d291bGRuJmFwb3M7dCZu
YnNwO2hhdmUmbmJzcDtsb3RzJm5ic3A7b2YmbmJzcDtlcnJvcnMmbmJzcDt3aGljaCZuYnNwO25l
ZWQmbmJzcDt0byZuYnNwO2JlJm5ic3A7bW9kaWZpZWQuPGJyIC8+QmVjYXVzZSwmbmJzcDttYW55
Jm5ic3A7c3VnZ2VzdGlvbnMmbmJzcDttYWRlJm5ic3A7aW4mbmJzcDtwcmV2aW91cyZuYnNwO3N1
Ym1pdHRpbmcmbmJzcDtwcm9jZXNzJm5ic3A7b2YmbmJzcDtjb21wcmVzc2lvbiZuYnNwO3BhdGNo
ZXM8YnIgLz5oYXZlJm5ic3A7YmVlbiZuYnNwO2Fkb3B0ZWQmbmJzcDtpbiZuYnNwO3RoZSZuYnNw
O3BhdGNoZXMmbmJzcDt0aGlzJm5ic3A7dGltZS48YnIgLz4NPGJyIC8+SSZuYnNwO3dpbGwmbmJz
cDttb2RpZnkmbmJzcDt0aGUmbmJzcDtyZWxlYXNlJm5ic3A7bm90ZSZuYnNwO2FuZCZuYnNwO3lv
dXJ0Jm5ic3A7c3VnZ2VzdGlvbnMmbmJzcDtpbiZuYnNwO3RoZSZuYnNwO25leHQmbmJzcDt2ZXJz
b24uPGJyIC8+DTxiciAvPkkmbmJzcDthbSZuYnNwO2hhcHB5Jm5ic3A7dG8mbmJzcDtoZWFyJm5i
c3A7ZnJvbSZuYnNwO3lvdS4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

