Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E27C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 10:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 025ED402DC;
	Thu, 15 May 2025 12:34:32 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
 by mails.dpdk.org (Postfix) with ESMTP id 1460640289
 for <dev@dpdk.org>; Thu, 15 May 2025 12:34:31 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZymmL3nQ3z8RTZV
 for <dev@dpdk.org>; Thu, 15 May 2025 18:34:26 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
 by mse-fl1.zte.com.cn with SMTP id 54FAY9je015555
 for <dev@dpdk.org>; Thu, 15 May 2025 18:34:09 +0800 (+08)
 (envelope-from li.hanxiao@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Thu, 15 May 2025 18:34:12 +0800
X-Zmail-TransId: 3e816825c31a004-c97e1
From: Hanxiao Li <li.hanxiao@zte.com.cn>
To: dev@dpdk.org
Subject: Re: [v3,3/9] crypto/zsda: add statistics
Date: Thu, 15 May 2025 18:30:59 +0800
Message-ID: <20250515103059.1926980-1-li.hanxiao@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515101927.1926502-4-li.hanxiao@zte.com.cn>
References: <20250515101927.1926502-4-li.hanxiao@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 54FAY9je015555
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6825C332.001/4ZymmL3nQ3z8RTZV
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

PiAtCS5zdGF0c19nZXQgPSBOVUxMLA0KPiAtCS5zdGF0c19yZXNldCA9IE5VTEwsDQo+ICsJLnN0
YXRzX2dldCA9IHpzZGFfY3J5cHRvX3N0YXRzX2dldCwNCj4gKwkuc3RhdHNfcmVzZXQgPSB6c2Rh
X2NyeXB0b19zdGF0c19yZXNldCwNCg0KSGkgQWtoaWwsDQoNCkFsdGhvdWdoIEkgd2FudCB0byBu
YW1lIHRoZSBmdW5jdGlvbiAienNkYV9zdGF0c19nZXQiIGFzIHlvdSBzdWdnZXN0ZWQsDQoNCmJ1
dCB0aGUgICJ6c2RhX2NyeXB0b19zdGF0c19nZXQiIHdpbGwgY2FsbCBhIGZ1bmN0aW9uICJ6c2Rh
X3N0YXRzX2dldCIgd2hpY2ggaW4gdGhlIGNvbW1vbiBmaWxlLg0KDQpCZXNpZGVzLCAienNkYV9z
dGF0c19nZXQiIGhhcyBhbHNvIGJlZW4gY2FsbGVkIGJ5IGNvbXByZXNzLCBzbyBJIG5hbWUgaXQg
InpzZGFfY3J5cHRvX3N0YXRzX2dldCIgaW4gY3J5cHRvLg0KDQpJIHdhbnQgdG8gd2FpdCB1bnRp
bCBjcnlwdG8gaXMgaW50ZWdyYXRlZCBiZWZvcmUgbWFraW5nIHVuaWZpZWQgY2hhbmdlcy4=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Jmd0OyZuYnNwOy0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuc3RhdHNfZ2V0Jm5ic3A7PSZuYnNw
O05VTEwsPGJyIC8+Jmd0OyZuYnNwOy0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsuc3RhdHNfcmVz
ZXQmbmJzcDs9Jm5ic3A7TlVMTCw8YnIgLz4mZ3Q7Jm5ic3A7KyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOy5zdGF0c19nZXQmbmJzcDs9Jm5ic3A7enNkYV9jcnlwdG9fc3RhdHNfZ2V0LDxiciAvPiZn
dDsmbmJzcDsrJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LnN0YXRzX3Jlc2V0Jm5ic3A7PSZuYnNw
O3pzZGFfY3J5cHRvX3N0YXRzX3Jlc2V0LDxiciAvPg08YnIgLz5IaSZuYnNwO0FraGlsLDxiciAv
Pg08YnIgLz5BbHRob3VnaCZuYnNwO0kmbmJzcDt3YW50Jm5ic3A7dG8mbmJzcDtuYW1lJm5ic3A7
dGhlJm5ic3A7ZnVuY3Rpb24mbmJzcDsmcXVvdDt6c2RhX3N0YXRzX2dldCZxdW90OyZuYnNwO2Fz
Jm5ic3A7eW91Jm5ic3A7c3VnZ2VzdGVkLDxiciAvPg08YnIgLz5idXQmbmJzcDt0aGUmbmJzcDsm
bmJzcDsmcXVvdDt6c2RhX2NyeXB0b19zdGF0c19nZXQmcXVvdDsmbmJzcDt3aWxsJm5ic3A7Y2Fs
bCZuYnNwO2EmbmJzcDtmdW5jdGlvbiZuYnNwOyZxdW90O3pzZGFfc3RhdHNfZ2V0JnF1b3Q7Jm5i
c3A7d2hpY2gmbmJzcDtpbiZuYnNwO3RoZSZuYnNwO2NvbW1vbiZuYnNwO2ZpbGUuPGJyIC8+DTxi
ciAvPkJlc2lkZXMsJm5ic3A7JnF1b3Q7enNkYV9zdGF0c19nZXQmcXVvdDsmbmJzcDtoYXMmbmJz
cDthbHNvJm5ic3A7YmVlbiZuYnNwO2NhbGxlZCZuYnNwO2J5Jm5ic3A7Y29tcHJlc3MsJm5ic3A7
c28mbmJzcDtJJm5ic3A7bmFtZSZuYnNwO2l0Jm5ic3A7JnF1b3Q7enNkYV9jcnlwdG9fc3RhdHNf
Z2V0JnF1b3Q7Jm5ic3A7aW4mbmJzcDtjcnlwdG8uPGJyIC8+DTxiciAvPkkmbmJzcDt3YW50Jm5i
c3A7dG8mbmJzcDt3YWl0Jm5ic3A7dW50aWwmbmJzcDtjcnlwdG8mbmJzcDtpcyZuYnNwO2ludGVn
cmF0ZWQmbmJzcDtiZWZvcmUmbmJzcDttYWtpbmcmbmJzcDt1bmlmaWVkJm5ic3A7Y2hhbmdlcy4=

--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

